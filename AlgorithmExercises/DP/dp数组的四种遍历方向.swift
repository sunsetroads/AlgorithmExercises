//
//  dp数组的四种遍历方向.swift
//  AlgorithmExercises
//
//  Created by 张宁 on 2020/4/23.
//  Copyright © 2020 张宁. All rights reserved.
//

import Foundation

fileprivate let remind =
"""
动态规划问题状态转移方程中， dp[i][j] 可能要依赖于 dp[i][j+1] dp[i-1][j] 等，
选择正确的遍历方法，才能在求 dp[i][j] 时已经计算过它依赖的值
这里给出套路模版，通过画 dp Table，确定 dp[i][j] 位于哪个位置，然后套用下面的遍历方式即可

dp[i][j] 在右下角时，正常遍历即可
dp[i][j] 在左上角时，倒着遍历即可，这种情况基本没有
dp[i][j] 在左下角时，dp table 中对角线和右上角一般已经作为 base case 计算出了
dp[i][j] 在右上角时，dp table 中对角线和左下角一般已经作为 base case 计算出了
"""
class Traverse {
    fileprivate let dp = [[1, 2, 3, 4],
             [5, 6, 7, 8],
             [9, 10, 11, 12],
             [13, 14, 15, 16]
    ]
    
    // dp[i][j] 在左上角
    func letTop() {
        for i in (0..<dp.count).reversed() {
            for j in (0..<dp.count).reversed() {
                print("i = \(i) j= \(j) dp[\(i)][\(j)] = \(dp[i][j]) \n")
            }
        }
    }
    
    // dp[i][j] 在左下角
    func letBottom() {
        for j in (0..<dp.count - 1).reversed() {
            for i in (j + 1)..<dp.count {
                print("i = \(i) j= \(j) dp[\(i)][\(j)] = \(dp[i][j]) \n")
            }
        }
    }
    
    // dp[i][j] 在右上角
    func rightTop() {
        for j in 1..<dp.count {
            for i in (0..<j).reversed() {
                print("i = \(i) j= \(j) dp[\(i)][\(j)] = \(dp[i][j]) \n")
            }
        }
    }
    
    // dp[i][j] 在右下角
    func rightBottom() {
        for j in 0..<dp.count {
            for i in 0..<dp.count {
                print("i = \(i) j= \(j) dp[\(i)][\(j)] = \(dp[i][j]) \n")
            }
        }
    }
}
