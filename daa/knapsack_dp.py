#Knapsack 0/1 problem using Dynamic Programming
def knapsack_01(weights, values, capacity):
    n = len(weights)

    
    dp = [[0] * (capacity + 1) for _ in range(n + 1)]

    
    for i in range(1, n + 1):
        for w in range(1, capacity + 1):
            if weights[i - 1] <= w:
                dp[i][w] = max(values[i - 1] + dp[i - 1][w - weights[i - 1]],
                               dp[i - 1][w])
            else:
                dp[i][w] = dp[i - 1][w]

  
    selected_items = []
    w = capacity
    for i in range(n, 0, -1):
        if dp[i][w] != dp[i - 1][w]:
            selected_items.append(i - 1) 
            w -= weights[i - 1]

    return dp[n][capacity], selected_items


weights = list(map(int, input("Enter weights (space-separated): ").split()))
values = list(map(int, input("Enter values (space-separated): ").split()))
capacity = int(input("Enter knapsack capacity: "))

max_val, chosen = knapsack_01(weights, values, capacity)

print("\nMaximum value that can be obtained:", max_val)
print("Selected item indices:", chosen[::-1]) 


################
# Example inputs:
#
# Weights,"[10, 20, 30]"
# Values,"[60, 100, 120]"
# Capacity,50
#
# Weights,"[4, 2, 1, 10, 12]"
# Values,"[12, 2, 1, 4, 1]"
# Capacity,15
################