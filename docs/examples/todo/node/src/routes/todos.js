const express = require('express');

/**
 * Create an Express router for todo endpoints.
 *
 * @param {import('../services/TodoService')} todoService - Injected service instance.
 * @returns {express.Router}
 */
function todosRouter(todoService) {
  const router = express.Router();

  /**
   * POST /todos — create a new todo.
   * Body: { title: string, description?: string }
   */
  router.post('/', async (req, res) => {
    try {
      const todo = await todoService.create(req.body.title, req.body.description);
      res.status(201).json(todo);
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  });

  /**
   * GET /todos — list all todos.
   */
  router.get('/', async (_req, res) => {
    const todos = await todoService.list();
    res.json(todos);
  });

  /**
   * PATCH /todos/:id/done — mark a todo as complete.
   */
  router.patch('/:id/done', async (req, res) => {
    try {
      const todo = await todoService.complete(req.params.id);
      res.json(todo);
    } catch (err) {
      res.status(404).json({ error: err.message });
    }
  });

  return router;
}

module.exports = todosRouter;
