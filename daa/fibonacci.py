#Recursive Version
def fibonacci_recursive(n):
    if n <= 1:
        return n
    return fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2)


num = int(input("Enter a number: "))
print("Fibonacci Using the Recursive Function")
print(f"Fibonacci({num}) =", fibonacci_recursive(num))



#Non-Recursive (Iterative) Version
def fibonacci_iterative(n):
    if n <= 1:
        return n

    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b

    return b


num = int(input("Enter a number: "))
print("Fibonacci Using Non-Recursive Function")
print(f"Fibonacci({num}) =", fibonacci_iterative(num))








