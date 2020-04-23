/*
* @lc app=leetcode.cn id=516 lang=swift
*
* [516] 最长回文子序列
*
* https://leetcode-cn.com/problems/longest-palindromic-subsequence/description/
*
* algorithms
* Medium (48.11%)
* Likes:    178
* Dislikes: 0
* Total Accepted:    16.6K
* Total Submissions: 31.3K
* Testcase Example:  '"bbbab"'
*
* 给定一个字符串s，找到其中最长的回文子序列。可以假设s的最大长度为1000。
*
* 示例 1:
* 输入:
*
*
* "bbbab"
*
*
* 输出:
*
*
* 4
*
*
* 一个可能的最长回文子序列为 "bbbb"。
*
* 示例 2:
* 输入:
*
*
* "cbbd"
*
*
* 输出:
*
*
* 2
*
*
* 一个可能的最长回文子序列为 "bb"。
*
*/

fileprivate let remind =
"""
dp[i][j] 表示 s[i...j] 的最长回文子串

s[i] == s[j] 时 dp[i][j] = dp[i + 1][j - 1] + 2
s[i] != s[j] 时取 dp[i + 1][j] dp[i][j - 1]的最大值

麻烦的地方在于如何确定 base case
j 必需大于 i
j == i 时返回 1

dp[i][j] 依赖于dp[i + 1][j] dp[i][j - 1] dp[i + 1][j - 1] 画下 DP table 可以看出来需要反着遍历 i，才能先求出 dp[i][j] 依赖的状态。
而对于 j，也只需要遍历 大于 i 的部分
"""

func longestPalindromeSubseq(_ s: String) -> Int {
    let sArr = Array(s)
    var dp = Array(repeating: Array(repeating: 0, count: s.count), count: s.count)
    for i in 0..<s.count {
        dp[i][i] = 1
    }
    
   for j in 1..<sArr.count {
        for i in (0..<j).reversed() {
            if sArr[i] == sArr[j] {
                dp[i][j] = dp[i + 1][j - 1] + 2
            } else {
                dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])
            }
        }
    }
    return dp[0][s.count - 1]
}
