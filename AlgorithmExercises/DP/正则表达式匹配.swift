/*
* @lc app=leetcode.cn id=10 lang=swift
*
* [10] 正则表达式匹配
*
* https://leetcode-cn.com/problems/regular-expression-matching/description/
*
* algorithms
* Hard (24.18%)
* Likes:    577
* Dislikes: 0
* Total Accepted:    24.2K
* Total Submissions: 99.8K
* Testcase Example:  '"aa"\n"a"'
*
* 给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
*
* '.' 匹配任意单个字符
* '*' 匹配零个或多个前面的那一个元素
*
*
* 所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。
*
* 说明:
*
*
* s 可能为空，且只包含从 a-z 的小写字母。
* p 可能为空，且只包含从 a-z 的小写字母，以及字符 . 和 *。
*
*
* 示例 1:
*
* 输入:
* s = "aa"
* p = "a"
* 输出: false
* 解释: "a" 无法匹配 "aa" 整个字符串。
*
*
* 示例 2:
*
* 输入:
* s = "aa"
* p = "a*"
* 输出: true
* 解释: 因为 '*' 代表可以匹配零个或多个前面的那一个元素, 在这里前面的元素就是 'a'。因此，字符串 "aa" 可被视为 'a' 重复了一次。
*
*
* 示例 3:
*
* 输入:
* s = "ab"
* p = ".*"
* 输出: true
* 解释: ".*" 表示可匹配零个或多个（'*'）任意字符（'.'）。
*
*
* 示例 4:
*
* 输入:
* s = "aab"
* p = "c*a*b"
* 输出: true
* 解释: 因为 '*' 表示零个或多个，这里 'c' 为 0 个, 'a' 被重复一次。因此可以匹配字符串 "aab"。
*
*
* 示例 5:
*
* 输入:
* s = "mississippi"
* p = "mis*is*p*."
* 输出: false
*
*/

import Foundation

fileprivate let remind =
"""
此题关键在于如何处理 * 号，可能有两种情况，匹配 0 次，或者匹配多次（包含一次）
使用备忘录解法需要注意边界，处理 * 号，递归即可
使用DP数组记录状态，画下 DP Table 会清晰很多
"""

// dp
class RegularSolution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let sArr = Array(s)
        let pArr = Array(p)
        // 默认全为false
        var dp = Array(repeating: Array(repeating: false, count: p.count + 1), count: s.count + 1)
        dp[0][0] = true
        //填充 dp[0][...]
        for i in 0..<p.count{
            if pArr[i] == "*" && dp[0][i-1]{
                dp[0][i+1] = true
            }
        }
        for i in 0..<s.count{
            for j in 0..<p.count{
                if pArr[j] == sArr[i]{
                    dp[i+1][j+1] = dp[i][j]
                }else if pArr[j] == "."{
                    dp[i+1][j+1] = dp[i][j]
                }else if pArr[j] == "*"{
                    if pArr[j-1] != sArr[i] && pArr[j-1] != "."{
                        // * 匹配0次
                        dp[i+1][j+1] = dp[i+1][j-1];
                    }else{
                        // * 匹配多次 dp[i+1][j]
                        // * 匹配0次 dp[i+1][j-1]
                        dp[i+1][j+1] = dp[i][j+1] || dp[i+1][j-1]
                    }
                }
            }
        }
        return dp[s.count][p.count]
    }
}

/// memo
class RegularSolution2 {
    var memo = [[Bool?]]()

    func isMatch(_ s: String, _ p: String) -> Bool {
        let sArr = Array(s)
        let pArr = Array(p)
        // 处理边界问题，把memo 长度 +1 会方便很多
        memo = Array(repeating: Array(repeating: nil, count: p.count + 1), count: s.count + 1)
        return match(0, 0, sArr, pArr)
    }
    
    func match(_ i:Int, _ j:Int, _ text:Array<Character>, _ pattern:Array<Character>) -> Bool {
        
        if let res = memo[i][j] {
            return res
        }
        
        var ans:Bool
        
        if j == pattern.count {
            // pattern 遍历完了，如果 text 也遍历，则完说明前面的都匹配上了
            ans = i == text.count
        } else {
            
            // i >= text.count 时当前不匹配， 防止 memo 中 i 溢出
            let curMatch = i < text.count && (text[i] == pattern[j] || pattern[j] == ".")
            
            // j + 1 < pattern.count 防止 memo 中 j 溢出
            if j + 1 < pattern.count && pattern[j + 1] == "*" {
               ans = match(i, j + 2, text, pattern) || (curMatch && match(i + 1, j, text, pattern))
            } else {
                ans = curMatch && match(i + 1, j + 1, text, pattern)
            }
        }

        memo[i][j] = ans
        
        return ans
    }
}
