fileprivate let problem =
"""
给你一个可装载重量为 W 的背包和 N 个物品，每个物品有重量和价值两个属性。其中第 i 个物品的重量为 wt[i]，价值为 val[i]，现在让你用这个背包装物品，最多能装的价值是多少？

举个简单的例子，输入如下：
N = 3, W = 4
wt = [2, 1, 3]
val = [4, 2, 3]
算法返回 6，选择前两件物品装进背包，总重量 3 小于 W，可以获得最大价值 6。
"""

fileprivate let remind =
"""
dp 问题通常就是穷举所有可能，找出最佳方案，只是消除了一些重叠子问题
dp[i][j] 表示 第 i 个物品 j容量下的最大价值

dp[i - 1][j] 不装第 i 个物品
val[i - 1] + dp[i-1][w - wt[i - 1]] 装第 i 个物品
"""

func knapsack(_ w:Int, _ n:Int, _ wt:[Int], _ val:[Int]) -> Int {
    
    var dp = Array(repeating: Array(repeating: 0, count: w + 1), count: n + 1)
    
    for i in 1...n {
        for j in 1...w {
            if wt[i - 1] > j {
                dp[i][j] = dp[i - 1][j]
            } else {
                dp[i][j] = max(dp[i - 1][j], val[i - 1] + dp[i-1][w - wt[i - 1]])
            }
        }
    }
    
    return dp[n][w];
}
