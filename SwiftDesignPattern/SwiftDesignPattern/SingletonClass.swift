//
//  singleton.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/29.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 单例模式，保证一个类仅有一个实例，并提供一个访问它的全局访问点
// 私有init以保证无法新生成,也让子类无法重写

import Foundation

class SingletonObject:CustomDebugStringConvertible {
    var debugDescription: String{
        return Unmanaged.passUnretained(self).toOpaque().debugDescription
    }
    var data:Int = 0
    static let sharedInstance = SingletonObject()
    private init(){}  
}


//class SingletonSubClass: SingletonObject {
//    override init() {
//
//
//    }
//}
