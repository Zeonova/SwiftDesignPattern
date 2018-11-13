//
//  Composite.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/12.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  复合模式 (组合模式的名称容易误解,理解成A+B=C,实际上应该是 A+a = Aa) 容器结构，递归结构
//  能够使容器与内容具有一致性，创造出递归结构的模式

import Foundation

//  抽象类的实践中,我觉得最合适的方式就是协议和类进行别名组合实现
//  并且绝不在 extension 为 protocol 实现声明的函数,而是在无关联的class中实现

typealias Entry = AbstractEntry & AbstractEntryMethod

protocol AbstractEntryMethod {
    func getName() -> String
    func getSize() -> Int
    func printList(prefix:String)
    func add(_ entry:Entry)  //该可选函数被交由无关联class实现
}
class AbstractEntry {
    func add(_ entry:Entry) {
        preconditionFailure("Method need override")
    }
}
extension AbstractEntryMethod where Self: AbstractEntry {
    func printList() {
        printList(prefix: "")
    }
    func toString() -> String {
        return getName() + " (" + String(getSize()) + ")"
    }
}


class File: Entry {
    
    private var name:String
    private var size:Int
    init(_ name:String, size:Int) {
        self.name = name
        self.size = size
    }
    func getName() -> String {
        return name
    }
    func getSize() -> Int {
        return size
    }
    func printList(prefix: String) {
        print(prefix + "/" + self.toString())
    }
}

class Directory: Entry {
    private var name:String
    private var directory:[Entry]
    private var nameSet:Set<String>
    init(_ name:String) {
        self.name = name
        directory = [Entry]()
        nameSet = []
    }
    func getName() -> String {
        return name
    }
    
    func getSize() -> Int {
        var size = 0
        for entry in directory {
            size += entry.getSize()
        }
        return size
    }
    func printList(prefix: String) {
        print(prefix + "/" + self.toString())
        for entry in directory {
            entry.printList(prefix: prefix + "/" + name)
        }
    }
    override func add(_ entry: Entry)   {
        if !nameSet.contains(entry.getName()){
            directory.append(entry)
            nameSet.insert(entry.getName())
        }
    }
}
