//
//  Observer.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/15.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//  观察者模式

import Foundation
// 抽象层
typealias Observer = ObserverMethod & ObserverClass
protocol ObserverMethod {
    func update(generator:NumberGenerator)
}
class ObserverClass: Equatable {
    static func == (lhs: ObserverClass, rhs: ObserverClass) -> Bool {
        return lhs === rhs
    }
}

typealias NumberGenerator = NumberGeneratorClass & NumberGeneratorMethod
class NumberGeneratorClass {
    private( set ) var observers:[Observer] = []
    func addObserver(ob:Observer) {
        observers.append(ob)
    }
    func deleteObserver(ob:Observer) {
        observers = observers.filter {!($0 == ob)}
    }
    func notifyObservers() {
        for item in observers {
            item.update(generator: self as! NumberGenerator)
        }
    }
}
protocol NumberGeneratorMethod {
    func getNumber() -> Int
    func execute()
}


// 具体实现

class RandomNumberGenerator: NumberGenerator {
    private var number:Int?
    func getNumber() -> Int{
        return number!
    }
    
    func execute() {
        for _ in 0..<20 {
            number = Int.random(in: 0..<50)
            notifyObservers()
        }
    }
    
}

class DigitObserver: Observer {
    func update(generator: NumberGenerator) {
        print("DigitObserver \(generator.getNumber())")
        Thread.sleep(forTimeInterval: 2)
    }
}

class GraphObserver: Observer {
    func update(generator: NumberGenerator) {
        print("GraphObserver")
        for _ in 0..<generator.getNumber() {
            print("*",terminator:"")
        }
        print("")
        Thread.sleep(forTimeInterval: 2)
    }
}
