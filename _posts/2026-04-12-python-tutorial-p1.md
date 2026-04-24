---
layout: post
title: "Python Tutorial Part 1"
date: 2026-04-12
categories: [Python, Robotics-Prep]
---

Following my roadmap toward Robotics and AI, **I’ll be focusing on refreshing my Python fundamentals over the next few weeks.**

With full docs already available on **[W3Schools](https://www.w3schools.com/python/)**, I’m providing a quick recap here to avoid redundancy. Instead, I’ve dedicated this post to capturing my personal insights, hands-on experiments, and the 'Aha!' moments (and questions) I encountered along the way. 

This week focuses on **Python Data Types** as I'll dive deep into their unique properties, structural differences, and the methods that make them so powerful for real-world implementation.

This is just **Part 1** of my Python review series. I’ll be tackling the remaining modules in the coming weeks, so stay tuned!

---

### 🐍 Python Fundamentals (Part 1)

<details>
<summary><b>1. Python Syntax & Comments</b></summary>

Indentation: Python uses indentation to indicate a block of code. Missing spaces will result in an IndentationError.

Comments: Use `#` for single-line comments and `""" """` for multi-line docstrings.

```bash

if 5 > 2:
    print("Correct indentation!") # This is a single-line comment

"""
This is
a multi-line
comment.
"""
```

</details>

<details>
<summary><b>2. Python Variables</b></summary>

<b>The Essentials</b>

- No command for declaring variables; they are created the moment you assign a value. 
- Use type() to check the data type.
    ```bash
    x = 5
    y = "John"
    print(type(x))
    print(type(y))
    ```
- Use casting (int(), float(), str(),...) to convert between them.
    ```bash
    x = str(3)    # x will be '3'
    y = int(3)    # y will be 3
    z = float(3)  # z will be 3.0 
    ```
- String variables can be declared either by using single or double quotes:
    ```bash
    x = "John"
    # is the same as
    x = 'John'
    ```
- Variable names are case-sensitive.
- Assign Multiple Values:
    - Many values - Multiple variables:
        ```bash
        x, y, z = "Orange", "Banana", "Cherry"
        ```
    - One Value to Multiple Variables:
        ```bash
        x = y = z = "Orange"
        ```
    - Unpack a Collection:
        ```bash
        fruits = ["apple", "banana", "cherry"]
        x, y, z = fruits
        ```
<b>Python Global Variables</b>

Global Variables are created outside of any function. They can be accessed by everyone, both inside and outside of functions.

- Global vs. Local:
    - Local Variable: If you create a variable with the same name inside a function, it is "local" to that function.
    - Independence: Changing a local variable will not affect the global variable of the same name.
- The `global` Keyword: The global keyword is used in two specific scenarios inside a function:
    - To Create: To declare a global variable from within a function's scope.
    - To Modify: To change the value of an existing global variable.

<b>Example:</b>

```bash
    x = "Global"

    def my_function():
        x = "Local"        # Local variable: Only exists inside here
        print(x)

    def modify_global():
        global x           # Use 'global' keyword to link to the outside x
        x = "Modified"     # This changes the actual global variable

    my_function()          # Prints: Local
    print(x)               # Prints: Global
    modify_global()
    print(x)               # Prints: Modified
```

</details>

<details>
<summary><b>3. Python Data Types</b></summary>

In programming, data type is an important concept. Variables can store data of different types, and different types can do different things.

Python has the following data types built-in by default, in these categories:

| Category | Data Types |
| :--- | :--- |
| **Text Type** | `str` |
| **Numeric Types** | `int`, `float`, `complex` |
| **Sequence Types** | `list`, `tuple`, `range` |
| **Mapping Type** | `dict` |
| **Set Types** | `set`, `frozenset` |
| **Boolean Type** | `bool` |
| **Binary Types** | `bytes`, `bytearray`, `memoryview` |
| **None Type** | `NoneType` |

Getting the Data Type => use `type()` function:
```bash
x = 5
print(type(x))
```

Setting the Data Type
*(In Python, the data type is set when you assign a value to a variable)*

| Example | Data Type |
| :--- | :--- |
| `x = "Hello World"` | `str` |
| `x = 20` | `int` |
| `x = 20.5` | `float` |
| `x = 1j` | `complex` |
| `x = ["apple", "banana", "cherry"]` | `list` |
| `x = ("apple", "banana", "cherry")` | `tuple` |
| `x = range(6)` | `range` |
| `x = {"name" : "John", "age" : 36}` | `dict` |
| `x = {"apple", "banana", "cherry"}` | `set` |
| `x = frozenset({"apple", "banana", "cherry"})` | `frozenset` |
| `x = True` | `bool` |
| `x = b"Hello"` | `bytes` |
| `x = bytearray(5)` | `bytearray` |
| `x = memoryview(bytes(5))` | `memoryview` |
| `x = None` | `NoneType` |

</details>