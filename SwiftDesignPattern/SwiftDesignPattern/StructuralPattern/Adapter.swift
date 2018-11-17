//
//  Adapter.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/7.
//  Copyright © 2018年 Mr.Z. All rights reserved.
// print(class_getSuperclass(type(of: a)) as Any)
// SwiftObject

// 适配器模式，适配器以包装目标接口成为指定的接口的形式
// 角色： 抽象目标/适配器/被适配者

import Foundation

protocol AbsTarget {
    func request()
}
// 适配器 对象型适配器
class Adapter:AbsTarget {
    private var adaptee:Adaptee
    init(adaptee:Adaptee) {
        self.adaptee = adaptee
    }
    func request() {
        self.adaptee.specificRequest()
    }
}
// 适配器 类适配器
class AdapterII: Adaptee,AbsTarget {
    func request() {
        specificRequest()
    }
}
// 被适配者
class Adaptee {
    func specificRequest(){
        print("---------->> \(self).\(#function)<<---------")
    }
}
