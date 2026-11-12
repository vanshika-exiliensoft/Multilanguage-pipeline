
from app.main import add, subtract, multiply, greet


def test_addition():
    assert add(10, 5) == 15


def test_subtraction():
    assert subtract(10, 5) == 5


def test_multiplication():
    assert multiply(10, 5) == 50


def test_greeting():
    assert greet("Developer") == (
        "Hello, Developer! Welcome to Python CI/CD."
    )
