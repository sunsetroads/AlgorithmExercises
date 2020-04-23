//
//  选石头博弈问题.swift
//  AlgorithmExercises
//
//  Created by 张宁 on 2020/4/23.
//  Copyright © 2020 张宁. All rights reserved.
//

import Foundation

fileprivate let problem =
"""
你和你的朋友面前有一排石头堆，用一个数组 piles 表示，piles[i] 表示第 i 堆石子有多少个。你们轮流拿石头，一次拿一堆，但是只能拿走最左边或者最右边的石头堆。所有石头被拿完后，谁拥有的石头多，谁获胜。
石头的堆数可以是任意正整数，石头的总数也可以是任意正整数，这样就能打破先手必胜的局面了。比如有三堆石头 piles = [1, 100, 3]，先手不管拿 1 还是 3，能够决定胜负的 100 都会被后手拿走，后手会获胜。
假设两人都很聪明，请你设计一个算法，返回先手和后手的最后得分（石头总数）之差。比如上面那个例子，先手能获得 4 分，后手会获得 100 分，你的算法应该返回 -96。

例子：
输入: [3, 9, 1, 2]
输出:  7
"""

func stoneGame(_ piles: [Int]) -> Int {
    
    var dp:[[(Int, Int)]] = Array(repeating: Array(repeating: (0,0), count: piles.count), count: piles.count)
    
    for i in 0..<piles.count {
        dp[i][i] = (piles[i], 0)
    }
    
    for j in 1..<dp.count {
        for i in (0..<j).reversed() {
            let left = piles[i] + dp[i + 1][j].1
            let right = piles[j] + dp[i][j - 1].1
            if left > right {
                dp[i][j].0 = left
                dp[i][j].1 = dp[i + 1][j].0
            } else {
                dp[i][j].0 = right
                dp[i][j].1 = dp[i][j - 1].0
            }
        }
    }
    let res = dp[0][piles.count - 1]
    return res.0 - res.1
}

