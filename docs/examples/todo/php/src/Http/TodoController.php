<?php

declare(strict_types=1);

namespace App\Http;

use App\Application\TodoService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Routing\RouteCollectorProxy;

/**
 * HTTP controller for todo endpoints (Interface Segregation).
 *
 * Each method handles exactly one route. The controller is stateless;
 * the injected service owns all business logic.
 */
final class TodoController
{
    /**
     * @param TodoService $service Injected business-logic service.
     */
    public function __construct(
        private readonly TodoService $service,
    ) {
    }

    /**
     * Register all todo routes on the given route group.
     *
     * @param RouteCollectorProxy $group Slim route group.
     */
    public function register(RouteCollectorProxy $group): void
    {
        $group->post('', [$this, 'create']);
        $group->get('', [$this, 'list']);
        $group->patch('/{id}/done', [$this, 'complete']);
    }

    /**
     * POST /todos — create a new todo.
     */
    public function create(Request $request, Response $response): Response
    {
        $body = (array) $request->getParsedBody();

        try {
            $todo = $this->service->create(
                (string) ($body['title'] ?? ''),
                (string) ($body['description'] ?? ''),
            );
            $response->getBody()->write((string) json_encode($todo->toArray()));

            return $response->withHeader('Content-Type', 'application/json')->withStatus(201);
        } catch (\InvalidArgumentException $e) {
            $response->getBody()->write((string) json_encode(['error' => $e->getMessage()]));

            return $response->withHeader('Content-Type', 'application/json')->withStatus(400);
        }
    }

    /**
     * GET /todos — list all todos.
     */
    public function list(Request $request, Response $response): Response
    {
        $todos = array_map(
            static fn ($t) => $t->toArray(),
            $this->service->listAll(),
        );

        $response->getBody()->write((string) json_encode($todos));

        return $response->withHeader('Content-Type', 'application/json');
    }

    /**
     * PATCH /todos/{id}/done — mark a todo as complete.
     */
    public function complete(Request $request, Response $response, array $args): Response
    {
        try {
            $todo = $this->service->complete((string) $args['id']);
            $response->getBody()->write((string) json_encode($todo->toArray()));

            return $response->withHeader('Content-Type', 'application/json');
        } catch (\RuntimeException $e) {
            $response->getBody()->write((string) json_encode(['error' => $e->getMessage()]));

            return $response->withHeader('Content-Type', 'application/json')->withStatus(404);
        }
    }
}
