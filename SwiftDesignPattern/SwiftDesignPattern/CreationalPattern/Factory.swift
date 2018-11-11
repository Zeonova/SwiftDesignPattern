//
//  Factory.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/27.
//  Copyright © 2018年 Mr.Z. All rights reserved.

// 创建型模式(Creational Pattern)对类的实例化过程进行了抽象，能够将软件模块中对象的创建和对象的使用分离。
// 为了使软件的结构更加清晰，外界对于这些对象只需要知道它们共同的接口，而不清楚其具体的实现细节，使整个系统的设计更加符合单一职责原则。
// 创建型模式在创建什么(What)，由谁创建(Who)，何时创建(When)等方面都为软件设计者提供了尽可能大的灵活性。
// 创建型模式隐藏了类的实例的创建细节，通过隐藏对象如何被创建和组合在一起达到使整个系统独立的目的。

// 工厂方法，也称为虚构造器，用于一个类无法预期需要生成哪个类的对象，想让其子类来制定所生成的对象
// 定义创建对象的接口，让子类决定实例化哪一个类，工厂方法使得一个类的实例化延迟到其子类 （NSNumber)
// 配置为 抽象产品/具体工厂/具体产品


import Foundation

class AbstractProduct {
    required init() {
        
    }
}
protocol AbstractProductMethod {
    func use()
}
protocol AbstractFactoryProtocol {
    static func creatFor<T:AbstractProduct>(subclass:T.Type) -> T? where T :AbstractProductMethod
}


class ConcreteFactory: AbstractFactoryProtocol {
    static func creatFor<T>(subclass: T.Type) -> T? where T : AbstractProduct, T : AbstractProductMethod {
        return subclass.init()
    }
    
}
class ConcreteProduct: AbstractProduct,AbstractProductMethod {
    func use() {
        print("---------->> \(self).\(#function)<<---------")
    }
}

