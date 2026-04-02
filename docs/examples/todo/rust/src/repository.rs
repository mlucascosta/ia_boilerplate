//! In-memory implementation of [`TodoRepository`] (Single Responsibility Principle).

use async_trait::async_trait;
use chrono::Utc;
use std::collections::HashMap;
use tokio::sync::RwLock;
use uuid::Uuid;

use crate::domain::{Todo, TodoRepository};

/// Thread-safe in-memory store backed by a `RwLock<HashMap>`.
pub struct MemoryRepo {
    store: RwLock<HashMap<String, Todo>>,
}

impl MemoryRepo {
    /// Create an empty repository.
    pub fn new() -> Self {
        Self {
            store: RwLock::new(HashMap::new()),
        }
    }
}

#[async_trait]
impl TodoRepository for MemoryRepo {
    async fn save(&self, title: String, description: String) -> Result<Todo, String> {
        let todo = Todo {
            id: Uuid::new_v4().to_string(),
            title,
            description,
            done: false,
            created_at: Utc::now(),
        };
        let mut store = self.store.write().await;
        store.insert(todo.id.clone(), todo.clone());
        Ok(todo)
    }

    async fn find_all(&self) -> Result<Vec<Todo>, String> {
        let store = self.store.read().await;
        Ok(store.values().cloned().collect())
    }

    async fn mark_done(&self, id: &str) -> Result<Option<Todo>, String> {
        let mut store = self.store.write().await;
        match store.get_mut(id) {
            Some(todo) => {
                todo.done = true;
                Ok(Some(todo.clone()))
            }
            None => Ok(None),
        }
    }
}
