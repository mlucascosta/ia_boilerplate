//! HTTP handlers for the todo API.

use actix_web::{web, HttpResponse};
use serde::Deserialize;

use crate::service::TodoService;

/// JSON body for `POST /todos`.
#[derive(Deserialize)]
pub struct CreateRequest {
    /// Todo title (required).
    pub title: String,
    /// Optional description.
    #[serde(default)]
    pub description: String,
}

/// POST /todos — create a new todo.
pub async fn create(
    svc: web::Data<TodoService>,
    body: web::Json<CreateRequest>,
) -> HttpResponse {
    match svc.create(body.title.clone(), body.description.clone()).await {
        Ok(todo) => HttpResponse::Created().json(todo),
        Err(msg) => HttpResponse::BadRequest().json(serde_json::json!({ "error": msg })),
    }
}

/// GET /todos — list all todos.
pub async fn list(svc: web::Data<TodoService>) -> HttpResponse {
    match svc.list_all().await {
        Ok(todos) => HttpResponse::Ok().json(todos),
        Err(msg) => HttpResponse::InternalServerError().json(serde_json::json!({ "error": msg })),
    }
}

/// PATCH /todos/{id}/done — mark a todo as complete.
pub async fn complete(
    svc: web::Data<TodoService>,
    path: web::Path<String>,
) -> HttpResponse {
    match svc.complete(&path.into_inner()).await {
        Ok(todo) => HttpResponse::Ok().json(todo),
        Err(msg) => HttpResponse::NotFound().json(serde_json::json!({ "error": msg })),
    }
}

/// Register all todo routes.
pub fn configure(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/todos")
            .route("/", web::post().to(create))
            .route("/", web::get().to(list))
            .route("/{id}/done", web::patch().to(complete)),
    );
}
