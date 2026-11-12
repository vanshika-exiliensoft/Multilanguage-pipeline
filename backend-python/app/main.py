
def add(a, b):
    return a + b


def subtract(a, b):
    return a - b


def multiply(a, b):
    return a * b


def greet(name):
    return f"Hello, {name}! Welcome to Python CI/CD."


if __name__ == "__main__":
    print("Python CI/CD Demo")

    print("Addition:", add(10, 5))
    print("Subtraction:", subtract(10, 5))
    print("Multiplication:", multiply(10, 5))
    print(greet("Developer"))
