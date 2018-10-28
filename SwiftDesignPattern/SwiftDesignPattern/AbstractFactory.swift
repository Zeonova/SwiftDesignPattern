//
//  AbstractFactory.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/27.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

// 抽象工厂模式，提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类

// 抽象工厂和工厂模式很相似
//      抽象工厂                               工厂方法
// 通过对象组合创建抽象产品                 通过类继承创建抽象产品
//    创建多系列产品                           创建一种产品
//必须修改父类的接口才能支持新的产品     子类化创建者并重写工厂方法以创建新产品


// 个人见解:抽象工厂的概念，比较类似于 交通机械厂内聚合了飞机厂和汽车厂两种类型不同的(具体)工厂类，但是都有启动/驾驶/停止等相似动作

import Foundation

protocol AbstractSuperProtocol {
    func doit()
}

class AbstractSuperClass:AbstractSuperProtocol {
    func doit() {
        
    }
    static func loadSubClasForSuperType<T:SuperAbsClass>(subclass:T.Type) -> T? {
        return SuperAbsClass.loadSubClass(subclass: subclass)
    }

    static func loadSubClasForSuperType<T:SuperAbsOtherClass>(subclass:T.Type) -> T? {
        return SuperAbsOtherClass.loadSubClass(subclass: subclass)
    }
    
}



class SuperAbsClass:AbstractSuperProtocol {
    func doit() {
        self.doSomething()
    }
    
    required init() {
        
    }
    func doSomething() {
        print(self)
    }
    static func loadSubClass<T:SuperAbsClass>(subclass:T.Type) -> T? {
        return T()
    }
}
class SubAbsClassA: SuperAbsClass {
    override func doSomething() {
        print("hello \(self)")
    }
    
}



class SuperAbsOtherClass:AbstractSuperProtocol {
    func doit() {
        self.doOtherSomething()
    }
    
    required init() {
        
    }
    func doOtherSomething() {
        print("good \(self)")
    }
    static func loadSubClass<T:SuperAbsOtherClass>(subclass:T.Type) -> T? {
        return T()
    }
}

class SubAbsClassB: SuperAbsOtherClass {
    
}
