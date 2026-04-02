//! Composition root — wires implementations to abstractions and starts the server.

mod domain;
mod handler;
mod repository;
mod service;

use std::sync::Arc;

use actix_web::{web, App, HttpServer};

use repository::MemoryRepo;
use service::TodoService;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let repo = Arc::new(MemoryRepo::new());
    let svc = TodoService::new(repo);
    let svc_data = web::Data::new(svc);

    println!("Todo API listening on http://localhost:3000");

    HttpServer::new(move || {
        App::new()
            .app_data(svc_data.clone())
            .configure(handler::configure)
    })
    .bind("0.0.0.0:3000")?
    .run()
    .await
}
