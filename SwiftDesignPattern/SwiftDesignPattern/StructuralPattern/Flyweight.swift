//
//  Flyweight.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/17.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  享元模式 UITableVieCell复用的实现

import Foundation
class BigChar {
    private( set ) var charName:Character
    private( set ) var fontData:String
    /// 如果文件加载失败,请按照下列的方式设置目录
    /// product > scheme > edit scheme->options->workdictionary->use custom working dictionary - $(SRCROOT)/$(PROJECT_NAME)
    init(_ name:Character) {
        charName = name
        let file = "FlyweightFile/big\(name).txt"
        let path=URL(fileURLWithPath: file)
        let text=try! String(contentsOf: path)
        fontData = text
    }
    func printBigChar(){
        print(fontData)
        // 输出的对象标识符，用于查看是否复用
        print(ObjectIdentifier(self))
    }
}

class BigCharFactory {
    private( set ) var pool:Dictionary = [String:BigChar]()
    static let sharedInstance = BigCharFactory()
    private init(){
    }
    let lock = NSLock()
    func getBigCharForPool(charName:Character) -> BigChar {
        lock.lock()
        var b = pool[String(charName)]
        if b == nil{
            b = BigChar(charName)
            pool.updateValue(b!, forKey: String(charName))
        }
        lock.unlock()
        return b!
    }
    
}
class BigString {
    private( set ) var bigchars:[BigChar]
    init(_ string:String) {
        bigchars = []
        let factory = BigCharFactory.sharedInstance
        for item in string {
            bigchars.append(factory.getBigCharForPool(charName: item))
        }
    }
    func printBigString() {
        for item in bigchars {
            item.printBigChar()
        }
    }
}
