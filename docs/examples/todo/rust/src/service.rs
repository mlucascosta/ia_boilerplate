//! Business-logic layer for todo operations (SRP + DIP).

use std::sync::Arc;

use crate::domain::{Todo, TodoRepository};

/// Owns validation and domain rules.
///
/// Depends on the [`TodoRepository`] trait, not on a concrete implementation.
pub struct TodoService {
    repo: Arc<dyn TodoRepository>,
}

impl TodoService {
    /// Create a service backed by the given repository.
    pub fn new(repo: Arc<dyn TodoRepository>) -> Self {
        Self { repo }
    }

    /// Validate inputs and persist a new todo.
    ///
    /// # Errors
    /// Returns an error when the title is empty or exceeds 200 characters.
    pub async fn create(&self, title: String, description: String) -> Result<Todo, String> {
        if title.trim().is_empty() {
            return Err("title is required".into());
        }
        if title.len() > 200 {
            return Err("title must not exceed 200 characters".into());
        }
        self.repo.save(title, description).await
    }

    /// Return every todo, newest first.
    pub async fn list_all(&self) -> Result<Vec<Todo>, String> {
        let mut todos = self.repo.find_all().await?;
        todos.sort_by(|a, b| b.created_at.cmp(&a.created_at));
        Ok(todos)
    }

    /// Mark an existing todo as done.
    ///
    /// # Errors
    /// Returns an error when the todo is not found.
    pub async fn complete(&self, id: &str) -> Result<Todo, String> {
        self.repo
            .mark_done(id)
            .await?
            .ok_or_else(|| format!("todo {} not found", id))
    }
}
