<?php

declare(strict_types=1);

/**
 * Composition root — wires implementations to abstractions and starts the server.
 */

require __DIR__ . '/../vendor/autoload.php';

use App\Application\TodoService;
use App\Http\TodoController;
use App\Infrastructure\InMemoryTodoRepository;
use Slim\Factory\AppFactory;

$repository = new InMemoryTodoRepository();
$service    = new TodoService($repository);
$controller = new TodoController($service);

$app = AppFactory::create();
$app->addBodyParsingMiddleware();

$app->group('/todos', [$controller, 'register']);

$app->run();
