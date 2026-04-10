#!/usr/bin/env bash
# RTK hook for Gemini CLI — auto-rewrite shell commands to rtk equivalents
# Installed by: rtk init -g --gemini
# This file is the project-level hook reference; rtk init writes the global hook.

exec rtk hook gemini "$@"
