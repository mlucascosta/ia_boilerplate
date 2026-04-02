/**
 * Todo repository interface.
 *
 * Defines the contract for todo data access. Concrete implementations
 * can use in-memory storage, a database, or any other persistence layer.
 *
 * @interface
 */
class TodoRepository {
  /**
   * Persist a new todo.
   *
   * @param {{ title: string, description?: string }} data - Todo creation payload.
   * @returns {Promise<{ id: string, title: string, description: string, done: boolean, createdAt: string }>}
   */
  async save(data) {
    throw new Error('Not implemented');
  }

  /**
   * Retrieve all todos.
   *
   * @returns {Promise<Array<{ id: string, title: string, description: string, done: boolean, createdAt: string }>>}
   */
  async findAll() {
    throw new Error('Not implemented');
  }

  /**
   * Mark an existing todo as done.
   *
   * @param {string} id - Todo identifier.
   * @returns {Promise<{ id: string, title: string, description: string, done: boolean, createdAt: string } | null>}
   */
  async markDone(id) {
    throw new Error('Not implemented');
  }
}

module.exports = TodoRepository;
