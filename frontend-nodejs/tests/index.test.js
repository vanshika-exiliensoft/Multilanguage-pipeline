
const test = require('node:test');
const assert = require('node:assert');

const {
    add,
    subtract,
    multiply,
    greet
} = require('../src/index');

test('Addition should return the correct result', () => {
    assert.strictEqual(add(10, 5), 15);
});

test('Subtraction should return the correct result', () => {
    assert.strictEqual(subtract(10, 5), 5);
});

test('Multiplication should return the correct result', () => {
    assert.strictEqual(multiply(10, 5), 50);
});

test('Greeting should return a welcome message', () => {
    assert.strictEqual(
        greet('Vanshika'),
        'Hello, Vanshika! Welcome to Node.js CI/CD.'
    );
});
