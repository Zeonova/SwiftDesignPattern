//
//  TemplateMethod.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/10.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 模版方法模式
// 角色：抽象类/具体类
// 对应的抽象类完全由 protocol 和 extension 特性实现，缺陷是无法控制display的权限

import Foundation

protocol AbstractClass{
    func open()
    func print()
    func close()
}
extension AbstractClass{
    func display() {
        open()
        for _ in 0..<5 {
            print()
        }
        close()
    }
}


class CharDisplay: AbstractClass {
    var ch:String
    init(_ c:String) {
        ch = c
    }
    
    func open() {
        Swift.print("<<",terminator:"")
    }
    
    func print() {
        Swift.print(ch,terminator:"")
    }
    
    func close() {
        Swift.print(">>")
    }
}
