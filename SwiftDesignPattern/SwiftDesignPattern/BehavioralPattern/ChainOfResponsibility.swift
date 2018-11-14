//
//  ChainOfResponsibility.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/14.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  责任链模式
//  角色:处理者/具体的处理者/请求者
import Foundation

class Trouble {
    private var _number:Int
    var number:Int{
        return _number
    }
    init(_ n:Int) {
        _number = n
    }
    func toString() -> String {
        return "[Trouble " + String(_number) + "]"
    }
}

typealias Support = SupportBase & SupportAbstractMethod

protocol SupportAbstractMethod  {
    func resolve(t:Trouble) -> Bool
}
class SupportBase:CustomStringConvertible {
    var description: String{
        return "[" + name + "]"
    }
    private var name:String
    private( set ) var next:Support?
    init(_ n:String) {
        name = n
    }
    func setNext(next:Support) -> Support {
        self.next = next
        return next
    }
    func done(t:Trouble) {
        print(t.toString() + "is is resolved by" + self.description + ".")
    }
    func fail(t:Trouble)  {
        print(t.toString() + "cannot be resolved.")
    }
}
extension SupportAbstractMethod where Self:SupportBase{
    func support(t:Trouble) {
        if resolve(t: t) {
            done(t: t)
        }else if let n = next {
            n.support(t: t)
        }else{
            fail(t: t)
        }
    }
}

class LimitSupport: Support {
    private( set ) var limit:Int
    init(_ name:String,limit:Int) {
        self.limit = limit
        super.init(name)
    }
    func resolve(t: Trouble) -> Bool {
        if t.number < limit {
            return true
        }else{
            return false
        }
    }
}
class Oddsupport: Support {
    func resolve(t: Trouble) -> Bool {
        if t.number % 2 == 1 {
            return true
        }
        return false
    }
}
class SpecialSupport: Support {
    private( set ) var number:Int
    init(_ name:String, n:Int) {
        self.number = n
        super.init(name)
    }
    func resolve(t: Trouble) -> Bool {
        if t.number == number {
            return true
        }
        return false
    }
}
class  NoSupport: Support {
    func resolve(t: Trouble) -> Bool {
        return false
    }
}
