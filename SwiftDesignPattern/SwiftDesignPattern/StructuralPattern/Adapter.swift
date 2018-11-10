//
//  Adapter.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/7.
//  Copyright © 2018年 Mr.Z. All rights reserved.
// print(class_getSuperclass(type(of: a)) as Any)
// SwiftObject
// 结构型模式(Structural Pattern)描述如何将类或者对 象结合在一起形成更大的结构，
// 就像搭积木，可以通过 简单积木的组合形成复杂的、功能更为强大的结构。



// 适配器模式,与委托模式很像，但是实现的方向和功能不一样，适配器以包装目标接口成为指定的接口的形式，委托则是将这些功能的实现转交其他类
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

// 被适配者
class Adaptee {
    func specificRequest(){
        print("---------->> \(self).\(#function)<<---------")
    }
}
