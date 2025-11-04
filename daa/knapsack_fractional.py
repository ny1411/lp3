def fractional_knapsack(weights, values, capacity):
    items = []
    for i in range(len(weights)):
        ratio = values[i] / weights[i]
        items.append((ratio, weights[i], values[i]))

    items.sort(reverse=True)

    total_value = 0.0
    remaining_capacity = capacity

    print("\nSelected items and fractions:")
    for ratio, weight, value in items:
        if remaining_capacity == 0:
            break

        if weight <= remaining_capacity:
            remaining_capacity -= weight
            total_value += value
            print(f"Take full item: weight={weight}, value={value}")
        else:
            fraction = remaining_capacity / weight
            total_value += value * fraction
            print(f"Take {fraction*100:.2f}% of item: weight used={remaining_capacity}, value added={value*fraction:.2f}")
            remaining_capacity = 0

    return total_value


weights = list(map(int, input("Enter item weights (space-separated): ").split()))
values = list(map(int, input("Enter item values (space-separated): ").split()))
capacity = int(input("Enter knapsack capacity: "))

max_val = fractional_knapsack(weights, values, capacity)
print(f"\nMaximum value in knapsack = {max_val:.2f}")


################
# Example inputs:
#
# Weights  [10, 4, 12]
# Values   [60, 20, 30]
# Capacity 20
#
# Weights  [5, 15, 3]
# Values   [10, 45, 10]
# Capacity 17
################

