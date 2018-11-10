//
//  Prototype.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/27.
//  Copyright © 2018年 Mr.Z. All rights reserved.

//  原型模式 使用原型实例指定创建对象的种类，并通过复制这个原型创建新的对象
//  此模式的最低限度是生成对象的真实副本，以用作同一环境下其他相关事物的基础
//  浅复制，指针复制
//  深复制，指针复制和内存资源复制
//  objective-c中通行的做法是 NSCopying 协议 func copy(with zone: NSZone? = nil) -> Any{}
//  swift4 出现Codable协议后就可以采用下列的处理方式，实质上一个归档解档的操作
//  struct 等值类型 是deep copy


import Foundation

protocol Copyable: class, Codable {
    func copy() -> Self
}
extension Copyable {
    func copy() -> Self {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            fatalError("encode err")
        }
        let decoder = JSONDecoder()
        guard let target = try? decoder.decode(Self.self, from: data) else {
            fatalError("decode err")
        }
        return target
    }
}


struct TestStruct {
    var data = 0
}

class TestClass:Copyable,CustomDebugStringConvertible{
    var debugDescription: String{
        return Unmanaged.passUnretained(self).toOpaque().debugDescription
    }
    var data = 0
    
}

class TestClassSub: TestClass {
    
}
