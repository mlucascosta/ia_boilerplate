#!/usr/bin/env bash
# install-rtk.sh — OS-aware RTK installer
# RTK (Rust Token Killer): https://github.com/rtk-ai/rtk
# Reduces LLM token consumption by 60-90% on common dev commands.
#
# Usage:
#   ./scripts/install-rtk.sh              # Install RTK
#   ./scripts/install-rtk.sh --init-all   # Install + init for all detected AI tools

set -euo pipefail

RTK_VERSION_MIN="0.35.0"
INSTALL_DIR="$HOME/.local/bin"

# ── Colors ────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

info()    { printf "${CYAN}[rtk]${NC} %s\n" "$*"; }
success() { printf "${GREEN}[rtk] ✓${NC} %s\n" "$*"; }
warn()    { printf "${YELLOW}[rtk] ⚠${NC} %s\n" "$*"; }
die()     { printf "${RED}[rtk] ✗${NC} %s\n" "$*" >&2; exit 1; }

# ── OS Detection ──────────────────────────────────────────────────────────
detect_os() {
  local os kernel arch
  kernel="$(uname -s)"
  arch="$(uname -m)"

  case "$kernel" in
    Darwin)
      os="macos"
      ;;
    Linux)
      os="linux"
      ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
      os="windows"
      ;;
    *)
      die "Unsupported OS: $kernel"
      ;;
  esac

  echo "$os:$arch"
}

# ── Dependency Checks ─────────────────────────────────────────────────────
check_deps() {
  local os="$1"

  if [[ "$os" == "macos" ]]; then
    if ! command -v brew &>/dev/null; then
      warn "Homebrew not found. Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  fi

  if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
    die "curl or wget is required. Install one and retry."
  fi
}

# ── Version Check ─────────────────────────────────────────────────────────
rtk_is_current() {
  if ! command -v rtk &>/dev/null; then
    return 1
  fi
  local installed
  installed="$(rtk --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)"
  if [[ -z "$installed" ]]; then
    return 1
  fi
  # Simple version compare: installed >= min
  local IFS='.'
  read -ra inst <<< "$installed"
  read -ra minv <<< "$RTK_VERSION_MIN"
  for i in 0 1 2; do
    if (( ${inst[$i]:-0} > ${minv[$i]:-0} )); then return 0; fi
    if (( ${inst[$i]:-0} < ${minv[$i]:-0} )); then return 1; fi
  done
  return 0
}

# ── Installation ──────────────────────────────────────────────────────────
install_macos() {
  if command -v brew &>/dev/null; then
    info "Installing via Homebrew..."
    brew install rtk
  else
    install_quickinstall
  fi
}

install_linux() {
  install_quickinstall
}

install_quickinstall() {
  info "Installing via quick-install script (Linux/macOS)..."
  mkdir -p "$INSTALL_DIR"
  curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh

  # Ensure INSTALL_DIR is in PATH for this session
  export PATH="$INSTALL_DIR:$PATH"

  # Prompt user to add to shell profile if not already there
  local shell_profile=""
  if [[ "${SHELL:-}" == *zsh ]]; then
    shell_profile="$HOME/.zshrc"
  elif [[ "${SHELL:-}" == *bash ]]; then
    shell_profile="$HOME/.bashrc"
  fi

  if [[ -n "$shell_profile" ]] && ! grep -q 'local/bin' "$shell_profile" 2>/dev/null; then
    echo '' >> "$shell_profile"
    echo '# RTK — added by install-rtk.sh' >> "$shell_profile"
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$shell_profile"
    success "Added ~/.local/bin to PATH in $shell_profile"
  fi
}

install_windows() {
  die "Windows detected. Please install RTK manually:\n  winget install rtk-ai.rtk\n  or see: https://github.com/rtk-ai/rtk/blob/master/INSTALL.md"
}

install_cargo() {
  info "Installing via Cargo..."
  if ! command -v cargo &>/dev/null; then
    die "Cargo not found. Install Rust from https://rustup.rs/ first."
  fi
  cargo install --git https://github.com/rtk-ai/rtk
}

# ── AI Tool Detection & Init ──────────────────────────────────────────────
detect_and_init_ai_tools() {
  info "Detecting AI tools for RTK init..."

  local initialized=0

  # Claude Code
  if [[ -d "$HOME/.claude" ]] || command -v claude &>/dev/null; then
    info "Claude Code detected → running: rtk init -g"
    rtk init -g --auto-patch
    success "Claude Code → RTK hook installed"
    initialized=1
  fi

  # GitHub Copilot (VS Code — check for .github dir in project)
  if [[ -d ".github" ]]; then
    info "GitHub Copilot detected (project .github/) → running: rtk init -g --copilot"
    rtk init -g --copilot --auto-patch 2>/dev/null || rtk init -g --copilot
    success "GitHub Copilot → RTK hook installed"
    initialized=1
  fi

  # Gemini CLI
  if [[ -d "$HOME/.gemini" ]] || command -v gemini &>/dev/null; then
    info "Gemini CLI detected → running: rtk init -g --gemini"
    rtk init -g --gemini
    success "Gemini CLI → RTK hook installed"
    initialized=1
  fi

  # OpenAI Codex
  if [[ -d "$HOME/.codex" ]] || command -v codex &>/dev/null; then
    info "OpenAI Codex detected → running: rtk init -g --codex"
    rtk init -g --codex
    success "OpenAI Codex → RTK hook installed"
    initialized=1
  fi

  # Cursor
  if [[ -d "$HOME/.cursor" ]] || command -v cursor &>/dev/null; then
    info "Cursor detected → running: rtk init -g --agent cursor"
    rtk init -g --agent cursor
    success "Cursor → RTK hook installed"
    initialized=1
  fi

  if [[ $initialized -eq 0 ]]; then
    warn "No AI tools auto-detected. Run the appropriate init manually:"
    echo "  rtk init -g                  # Claude Code"
    echo "  rtk init -g --copilot        # GitHub Copilot"
    echo "  rtk init -g --gemini         # Gemini CLI"
    echo "  rtk init -g --codex          # OpenAI Codex"
    echo "  rtk init -g --agent cursor   # Cursor"
  fi
}

# ── Main ──────────────────────────────────────────────────────────────────
main() {
  local init_all=false
  for arg in "$@"; do
    [[ "$arg" == "--init-all" ]] && init_all=true
  done

  printf "\n${BOLD}RTK Installer — Rust Token Killer${NC}\n"
  printf "Reduces LLM token consumption by 60-90%%\n"
  printf "Repository: https://github.com/rtk-ai/rtk\n\n"

  local os_arch
  os_arch="$(detect_os)"
  local os="${os_arch%%:*}"
  local arch="${os_arch##*:}"

  info "Detected OS: $os ($arch)"

  # Skip install if already current
  if rtk_is_current; then
    success "RTK is already installed and up to date: $(rtk --version 2>/dev/null)"
  else
    check_deps "$os"

    case "$os" in
      macos)   install_macos ;;
      linux)   install_linux ;;
      windows) install_windows ;;
    esac

    # Verify installation
    if ! command -v rtk &>/dev/null; then
      # Try cargo fallback
      warn "rtk not found in PATH after install, trying Cargo..."
      install_cargo
    fi

    if command -v rtk &>/dev/null; then
      success "RTK installed: $(rtk --version 2>/dev/null)"
    else
      die "RTK installation failed. See: https://github.com/rtk-ai/rtk/blob/master/docs/TROUBLESHOOTING.md"
    fi
  fi

  # AI tool init
  if [[ "$init_all" == true ]]; then
    detect_and_init_ai_tools
  else
    printf "\n${YELLOW}Next steps:${NC}\n"
    echo "  Initialize RTK for your AI tool:"
    echo "    rtk init -g                  # Claude Code (default)"
    echo "    rtk init -g --copilot        # GitHub Copilot (VS Code)"
    echo "    rtk init -g --gemini         # Gemini CLI"
    echo "    rtk init -g --codex          # OpenAI Codex"
    echo "    rtk init -g --agent cursor   # Cursor"
    echo ""
    echo "  Or run with --init-all to auto-detect and init all tools:"
    echo "    ./scripts/install-rtk.sh --init-all"
  fi

  printf "\n"
  success "Done. Run 'rtk gain' to see token savings stats."
  printf "\n"
}

main "$@"
