//
//  Iterator.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/10.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

// 迭代器模式

// 角色： 抽象迭代器/抽象集合/具体迭代器/具体集合
import Foundation

protocol Iterator {
    func hasNext() -> Bool
    /// next确切的说，是指返回当前的元素，并指向下一个元素
    func next()-> Any
}
protocol Aggregate {
    var iterator:Iterator { get }
}



class Item {
    var name:String
    init(_ n:String) {
        name = n
    }
    func getName() -> String {
        return name
    }
}
class ItemIterator: Iterator {
    private var index:Int = 0
    private var set:ItemSet
    init(_ s:ItemSet) {
        set = s
    }
    func hasNext() -> Bool {
        if index < set.getLength() {
            return true
        }
        return false
    }
    func next() -> Any {
        let item = set.getItemAt(index: index)
        index += 1
        return item
    }
}

class ItemSet: Aggregate {
    
    var iterator: Iterator{
        return ItemIterator(self)
    }
    private var items:[Item] = []
    
    func getItemAt(index:Int) -> Item {
        return items[index]
    }
    func appendItem(i:Item) {
        items.append(i)
    }
    func getLength() -> Int {
        return items.count
    }
}
