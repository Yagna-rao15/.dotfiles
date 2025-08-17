def add_numbers(a: int, b: int) -> int:
    return a + b


result = add_numbers("5", 10)  # ❌ Passing str instead of int

print(results)  # ❌ Undefined variable "results"

import math

print(math.sqroot(16))  # ❌ No function named 'sqroot' in math (should be 'sqrt')


class Person:
    def __init__(self, name):
        self.name = name

    def greet(self) -> str:
        return "Hello, " + self.names  # ❌ Typp: 'names' instead of 'name'
