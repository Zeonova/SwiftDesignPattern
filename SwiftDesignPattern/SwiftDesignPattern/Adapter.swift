//
//  Adapter.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/7.
//  Copyright © 2018年 Mr.Z. All rights reserved.
// print(class_getSuperclass(type(of: a)) as Any)
// SwiftObject
// 适配器模式
// 首先，它的定义是连接多种不同种类的对象，来进行协同工作
// 也就是说，外显类是适配器，然后由适配器去选择使用哪个实现类方法
// 与委托和抽象工厂模式对比来看,从实现角度上来看，是需要分为 行为协议/适配器（协议适配/继承适配）/ 多个具体实现类
// 从实现角度上来看，与生成器模式最大的不同是，行为协议的实现被分散到多个实现类中，每个实现类可以只实现想实现的方法

import Foundation

protocol Action {
    func hello()
    func work()
    func sleep()
}

class Adapter: Action{
    var type = 0
    
    func hello() {
        switch type {
        case 1:
            Speak().sayHelloForCn()
        default:
            Speak().sayHelloForEn()
        }
    }
    func work() {
        Company().work()

    }
    func sleep() {
        Furniture().sleepToBed()
    }
}


class Speak{
    func sayHelloForEn(){
        print("hello")
    }
    func sayHelloForCn(){
        print("你好")
    }
    func sayHelloForCnY(){
        print("雷好")
    }
}


class Company{
    
    func work(){
        print("work")
    }
    func notWork(){
        print("play")
    }
    func sleep(){
        print("sleep")
    }
}


class Furniture{
    func sleepToBed(){
        print("sleep")
    }
    func sleepToSofa(){
        print("Sofa")
    }
}
