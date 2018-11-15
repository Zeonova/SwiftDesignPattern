//
//  Memento.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/16.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  备忘录模式
//  备忘录模式,可以实现程序的以下功能
//  撤销,重做,历史记录,快照

import Foundation

class Memento:CustomStringConvertible {
    var description: String{
        return "恢复到 -> == <money = \(money),fruits = \(fruits)> =="
    }
    var money:Int
    var fruits:[String]
    func getMoney() -> Int {
        return money
    }
    init(_ money:Int) {
        self.money = money
        self.fruits = []
    }
    func addFruit(fruit:String) {
        fruits.append(fruit)
    }
    func getFruits() -> [String] {
        return fruits
    }
}

class Gamer:CustomStringConvertible {
    var description: String{
        return "[money = \(money),fruits = \(fruits)]"
    }
    private( set ) var money:Int
    private( set ) var fruits:[String]
    private var fruitsname = ["苹果","葡萄","香蕉","橘子"]
    init(_ m:Int) {
        self.money = m
        self.fruits = []
    }
    func bet()  {
        let dice = Int.random(in: 1...6)
        switch dice {
        case 1:
            money += 100
            print("所持金钱增加了")
        case 2:
            money /= 2
            print("所持金钱减半了")
        case 6:
            let s = getFruit()
            print("获得了（\(s)）")
            fruits.append(s)
        default:
            print("什么都没有发生")
        }
    }
    func getFruit() -> String {
        var prefix = ""
        if Bool.random(){
            prefix = "好吃的"
        }
        return prefix + fruitsname[Int.random(in: 0..<fruitsname.count)]
    }
    
    //  拍摄快照
    func createMemento() -> Memento {
        let m = Memento(money)
        for f in m.fruits {
            if f.contains("好吃的"){
                m.addFruit(fruit: f)
            }
        }
        return m
    }
    // 撤销
    func restoreMemento(memento:Memento) {
        self.money = memento.money
        self.fruits = memento.getFruits()
    }
    
}
