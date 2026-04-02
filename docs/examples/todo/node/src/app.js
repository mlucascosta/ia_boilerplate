const express = require('express');
const InMemoryTodoRepo = require('./repositories/InMemoryTodoRepo');
const TodoService = require('./services/TodoService');
const todosRouter = require('./routes/todos');

/**
 * Application composition root.
 *
 * Wires concrete implementations to abstractions and starts the server.
 */
const app = express();

app.use(express.json());

const repository = new InMemoryTodoRepo();
const service = new TodoService(repository);

app.use('/todos', todosRouter(service));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Todo API listening on http://localhost:${PORT}`);
});
