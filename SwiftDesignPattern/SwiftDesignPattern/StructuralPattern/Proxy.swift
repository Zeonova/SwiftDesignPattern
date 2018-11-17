//
//  Proxy.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/17.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  代理模式
//  代理模式和iOS常用的委托模式的区别很大
//  代理模式具有一致性,将重型角色轻量表象化用以占位
//  委托模式不具有一致性,引入协议实现类并以自身的抽象调用运行,实际上是桥接模式

import Foundation

// 用于保持一致性的协议
protocol Printable {
    var printerName:String{set get}
    func startPrint(text:String)
}

//  实际工作者
class Printer: Printable {
    var printerName: String = ""
    init() {
        heavyJob(msg: "正在生成Printer的实例")
    }
    init(_ name:String) {
        printerName = name
        heavyJob(msg: "正在生成Printer的实例(\(printerName))")
    }
    func startPrint(text: String) {
        print("===\(printerName)===")
        print(text.uppercased())
    }
    
    // 这个重型模拟方法是在模拟这是一个很复杂的类
    func heavyJob(msg:String) {
        print(msg)
        for _ in 0..<5 {
            Thread.sleep(forTimeInterval: 5)
            print(".")
        }
        print("结束.")
    }
}

// 代理人
class PrinterProxy: Printable {
    var printerName: String{
        didSet{
            real?.printerName = oldValue
        }
    }
    private var real:Printer?
    
    init(_ name:String) {
        printerName = name
    }
    func startPrint(text: String) {
        realize()
        real?.startPrint(text: text)
    }
    private func realize(){
        if real == nil {
            real = Printer(printerName)
        }
    }
    
}
