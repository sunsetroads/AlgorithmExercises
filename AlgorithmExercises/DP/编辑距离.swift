/*
 * @lc app=leetcode.cn id=72 lang=swift
 *
 * [72] 编辑距离
 *
 * https://leetcode-cn.com/problems/edit-distance/description/
 *
 * algorithms
 * Hard (55.33%)
 * Likes:    794
 * Dislikes: 0
 * Total Accepted:    52.2K
 * Total Submissions: 88.1K
 * Testcase Example:  '"horse"\n"ros"'
 *
 * 给你两个单词 word1 和 word2，请你计算出将 word1 转换成 word2 所使用的最少操作数 。
 *
 * 你可以对一个单词进行如下三种操作：
 *
 *
 * 插入一个字符
 * 删除一个字符
 * 替换一个字符
 *
 *
 *
 *
 * 示例 1：
 *
 * 输入：word1 = "horse", word2 = "ros"
 * 输出：3
 * 解释：
 * horse -> rorse (将 'h' 替换为 'r')
 * rorse -> rose (删除 'r')
 * rose -> ros (删除 'e')
 *
 *
 * 示例 2：
 *
 * 输入：word1 = "intention", word2 = "execution"
 * 输出：5
 * 解释：
 * intention -> inention (删除 't')
 * inention -> enention (将 'i' 替换为 'e')
 * enention -> exention (将 'n' 替换为 'x')
 * exention -> exection (将 'n' 替换为 'c')
 * exection -> execution (插入 'u')
 *
 *
 */
fileprivate let remind =
"""
状态转换：
dp[i][j] = dp[i - 1][j - 1] 跳过
dp[i - 1][j - 1] + 1 替换
dp[i - 1][j] + 1 删除
dp[i][j - 1] + 1 插入
"""
// @lc code=start
func minDistance(_ word1: String, _ word2: String) -> Int {
    let w1Arr = Array(word1)
    let w2Arr = Array(word2)
    
    var dp = Array(repeating: Array(repeating: 0, count: w2Arr.count + 1), count: w1Arr.count + 1)

    for i in 0...w1Arr.count {
        dp[i][0] = i
    }
    
    for j in 0...w2Arr.count{
        dp[0][j] = j
    }
    
    if !(w1Arr.isEmpty || w2Arr.isEmpty) {
        for i in 1...w1Arr.count {
               for j in 1...w2Arr.count {
                   if w1Arr[i - 1] == w2Arr[j - 1]{
                        //跳过
                       dp[i][j] = dp[i - 1][j - 1]
                   } else {
                        //dp[i - 1][j - 1] + 1 替换
                        //dp[i - 1][j] + 1 删除
                        //dp[i][j - 1] + 1 插入
                       dp[i][j] = min(dp[i - 1][j - 1] + 1, dp[i - 1][j] + 1, dp[i][j - 1] + 1)
                   }
               }
           }
    }

    return dp[w1Arr.count][w2Arr.count]
}
