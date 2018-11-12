//
//  Bridge.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/12.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

// 桥接模式
// 作用是将 类的功能层次结构 和 类的实现层次结构 连接起来
// 角色:抽象实现层/抽象功能层/具体实现层/具体功能层
import Foundation

protocol AbstractDisplayImpl {
    func rawOpen()
    func rawPrint()
    func rawClose()
}

class Display {
    private var impl:AbstractDisplayImpl
    init(_ impl:AbstractDisplayImpl) {
        self.impl = impl
    }
    func open() {
        impl.rawOpen()
    }
    func doPrint() {
        impl.rawPrint()
    }
    func close(){
        impl.rawClose()
    }
    final func display(){
        open()
        doPrint()
        close()
    }
}

class StringDisplayImpl: AbstractDisplayImpl {
    private var string:String
    private var width:Int
    init(_ text:String) {
        self.string = text
        self.width = text.count
    }
    func rawOpen() {
        printLine()
    }
    
    func rawPrint() {
        print("|\(string)|")
    }
    
    func rawClose() {
        printLine();
    }
    func printLine() {
        var string = "+"
        for _ in 0..<width {
            string += "-"
        }
        string += "+"
        print(string)
    }
}

class CountDisplay: Display {
    func multiDisplay(times:Int) {
        open()
        for _ in 0..<times {
            doPrint()
        }
        close()
    }
}
