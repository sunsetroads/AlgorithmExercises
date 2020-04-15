//
//  Node.swift
//  AlgorithmExercises
//
//  Created by 张宁 on 2020/4/10.
//  Copyright © 2020 张宁. All rights reserved.
//

import Foundation

/// Definition for singly-linked list.

 class ListNode {
     var val: Int
     var next: ListNode?
     init(_ val: Int) {
        self.val = val
    }
}

/// Definition for binary tree.

class TreeNode {
     var val: Int
     var left: TreeNode?
     var right: TreeNode?
     init(_ val: Int) {
        self.val = val
    }
}
