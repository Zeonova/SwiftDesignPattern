//
//  Factory.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/27.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 工厂方法，也称为虚构造器，用于一个类无法预期需要生成哪个类的对象，想让其子类来制定所生成的对象
// 定义创建对象的接口，让子类决定实例化哪一个类，工厂方法使得一个类的实例化延迟到其子类 （NSNumber)
// 配置为 抽象产品/具体工厂/具体产品
import Foundation

class AbstractProduct {
    required init() {
        
    }
    func use(){
        
    }
}

class ConcreteFactory {
    static func creatFor<T:AbstractProduct>(subclass:T.Type) -> T? {
        return T()
    }
}

class ConcreteProduct: AbstractProduct {
    override func use() {
        print("---------->> \(self).\(#function)<<---------")
    }
}

