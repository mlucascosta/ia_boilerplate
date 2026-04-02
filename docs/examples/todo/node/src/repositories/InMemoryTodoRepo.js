const crypto = require('crypto');
const TodoRepository = require('./TodoRepository');

/**
 * In-memory implementation of {@link TodoRepository}.
 *
 * Stores todos in a plain Map. Suitable for development and testing;
 * replace with a database-backed implementation for production.
 */
class InMemoryTodoRepo extends TodoRepository {
  constructor() {
    super();
    /** @type {Map<string, { id: string, title: string, description: string, done: boolean, createdAt: string }>} */
    this._store = new Map();
  }

  /** @inheritdoc */
  async save(data) {
    const id = crypto.randomUUID();
    const todo = {
      id,
      title: data.title,
      description: data.description || '',
      done: false,
      createdAt: new Date().toISOString(),
    };
    this._store.set(id, todo);
    return todo;
  }

  /** @inheritdoc */
  async findAll() {
    return Array.from(this._store.values());
  }

  /** @inheritdoc */
  async markDone(id) {
    const todo = this._store.get(id);
    if (!todo) return null;
    todo.done = true;
    return todo;
  }
}

module.exports = InMemoryTodoRepo;
