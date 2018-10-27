//
//  Factory.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/27.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 工厂方法，也称为虚构造器，用于一个类无法预期需要生成哪个类的对象，想让其子类来制定所生成的对象
// 定义创建对象的接口，让子类决定实例化哪一个类，工厂方法使得一个类的实例化延迟到其子类 （NSNumber)
import Foundation

class SuperClass {
    required init() {
        
    }
    func doSomething() {
        print(self)
    }
    static func loadSubClass<T:SuperClass>(subclass:T.Type) -> T? {
        return T()
    }
}
class SubclassA: SuperClass {
    override func doSomething() {
        print("hello \(self)")
    }

}

