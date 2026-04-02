//! Core domain types and the repository trait (Dependency Inversion Principle).

use async_trait::async_trait;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

/// A task in the system.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Todo {
    /// Unique identifier (UUID v4).
    pub id: String,
    /// Task title (required, max 200 chars).
    pub title: String,
    /// Optional description.
    pub description: String,
    /// Whether the task has been completed.
    pub done: bool,
    /// When the task was created.
    pub created_at: DateTime<Utc>,
}

/// Data-access contract for todos.
///
/// Higher-level code depends on this trait rather than on a concrete store,
/// following the Dependency Inversion Principle.
#[async_trait]
pub trait TodoRepository: Send + Sync {
    /// Persist a new todo and return it with a generated ID.
    async fn save(&self, title: String, description: String) -> Result<Todo, String>;

    /// Return every stored todo.
    async fn find_all(&self) -> Result<Vec<Todo>, String>;

    /// Set `done = true` for the given ID. Returns `None` when not found.
    async fn mark_done(&self, id: &str) -> Result<Option<Todo>, String>;
}
