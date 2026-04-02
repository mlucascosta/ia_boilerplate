const TodoRepository = require('../repositories/TodoRepository');

/**
 * Business-logic layer for todo operations.
 *
 * Depends on the {@link TodoRepository} abstraction (Dependency Inversion)
 * and owns all validation and domain rules (Single Responsibility).
 */
class TodoService {
  /**
   * @param {TodoRepository} repository - Concrete repository implementation.
   */
  constructor(repository) {
    this._repository = repository;
  }

  /**
   * Create a new todo after validating inputs.
   *
   * @param {string} title - Required, max 200 characters.
   * @param {string} [description=''] - Optional description.
   * @returns {Promise<{ id: string, title: string, description: string, done: boolean, createdAt: string }>}
   * @throws {Error} If title is empty or exceeds 200 characters.
   */
  async create(title, description = '') {
    if (!title || title.trim().length === 0) {
      throw new Error('Title is required');
    }
    if (title.length > 200) {
      throw new Error('Title must not exceed 200 characters');
    }
    return this._repository.save({ title: title.trim(), description });
  }

  /**
   * List all todos, newest first.
   *
   * @returns {Promise<Array<{ id: string, title: string, description: string, done: boolean, createdAt: string }>>}
   */
  async list() {
    const todos = await this._repository.findAll();
    return todos.sort((a, b) => b.createdAt.localeCompare(a.createdAt));
  }

  /**
   * Mark an existing todo as done.
   *
   * @param {string} id - Todo identifier.
   * @returns {Promise<{ id: string, title: string, description: string, done: boolean, createdAt: string }>}
   * @throws {Error} If the todo is not found.
   */
  async complete(id) {
    const todo = await this._repository.markDone(id);
    if (!todo) {
      throw new Error('Todo not found');
    }
    return todo;
  }
}

module.exports = TodoService;
