// Stack Implementation
class AsyncStack {
	constructor() {
		this.items = [];
	}

	async push(item) {
		try {
			await this.simulateAsyncOperation();
			this.items.push(item);
			return true;
		} catch (error) {
			throw new Error(`Failed to push item: ${error.message}`);
		}
	}

	async pop() {
		try {
			await this.simulateAsyncOperation();
			if (this.isEmpty()) {
				throw new Error('Stack is empty');
			}
			return this.items.pop();
		} catch (error) {
			throw new Error(`Failed to pop item: ${error.message}`);
		}
	}

	async peek() {
		await this.simulateAsyncOperation();
		if (this.isEmpty()) {
			return null;
		}
		return this.items[this.items.length - 1];
	}

	isEmpty() {
		return this.items.length === 0;
	}

	size() {
		return this.items.length;
	}

	// Simulate async operation (e.g., network request, database operation)
	simulateAsyncOperation() {
		return new Promise((resolve) => setTimeout(resolve, 100));
	}


}

// Queue Implementation
class AsyncQueue {
	constructor() {
		this.items = [];
	}

	async enqueue(item) {
		try {
			await this.simulateAsyncOperation();
			this.items.push(item);
			return true;
		} catch (error) {
			throw new Error(`Failed to enqueue item: ${error.message}`);
		}
	}

	async dequeue() {
		try {
			await this.simulateAsyncOperation();
			if (this.isEmpty()) {
				throw new Error('Queue is empty');
			}
			return this.items.shift();
		} catch (error) {
			throw new Error(`Failed to dequeue item: ${error.message}`);
		}
	}

	async peek() {
		await this.simulateAsyncOperation();
		if (this.isEmpty()) {
			return null;
		}
		return this.items[0];
	}

	isEmpty() {
		return this.items.length === 0;
	}

	size() {
		return this.items.length;
	}

	// Simulate async operation
	simulateAsyncOperation() {
		return new Promise((resolve) => setTimeout(resolve, 100));
	}
}

// Example usage with real-world scenario
async function processUserActions() {
	const actionStack = new AsyncStack();

	try {
		// Simulate user actions being added to stack
		console.log('Adding user actions to stack...');
		await actionStack.push({ type: 'EDIT_TEXT', value: 'Hello' });
		await actionStack.push({ type: 'CHANGE_COLOR', value: 'blue' });
		await actionStack.push({ type: 'RESIZE', value: { width: 100, height: 100 } });

		console.log('Total actions:', actionStack.size());
		console.log('Last action:', await actionStack.peek());

		// Simulate undo operations
		console.log('\nUndoing actions:');
		while (!actionStack.isEmpty()) {
			const action = await actionStack.pop();
			console.log('Undoing:', action.type);
		}
	} catch (error) {
		console.error('Error processing actions:', error.message);
	}
}

async function processTaskQueue() {
	const taskQueue = new AsyncQueue();

	try {
		// Simulate adding tasks to queue
		console.log('\nAdding tasks to queue...');
		await taskQueue.enqueue({ id: 1, task: 'Send email', priority: 'high' });
		await taskQueue.enqueue({ id: 2, task: 'Process image', priority: 'medium' });
		await taskQueue.enqueue({ id: 3, task: 'Backup data', priority: 'low' });

		console.log('Total tasks:', taskQueue.size());
		console.log('Next task:', await taskQueue.peek());

		// Process tasks
		console.log('\nProcessing tasks:');
		while (!taskQueue.isEmpty()) {
			const task = await taskQueue.dequeue();
			console.log('Processing:', task.task);
		}
	} catch (error) {
		console.error('Error processing tasks:', error.message);
	}
}

// Run demonstrations
async function runDemo() {
	try {
		await processUserActions();
		await processTaskQueue();
	} catch (error) {
		console.error('Demo error:', error.message);
	}
}

async function test() {
	await processUserActions();
	await processTaskQueue();
	console.log(2);
}

// Execute the demo
runDemo();