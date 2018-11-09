//
//  Builder.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/28.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 生成器模式：将一个复杂对象的构建与它的表现分离，使得同样的构建过程可以创建不同的表现
// 角色: 抽象建造者/具体建造者/指挥者/产品
import Foundation

// 产品
class Role{
    var name:String?
    var sex:String?
    var skinColour:String?
    func show() {
        print("\(String(describing: name)). \(String(describing: sex)). \(String(describing: skinColour))")
    }
}

protocol AbstractBuilder {
    var role:Role{ get set }
    func buiderName()
    func buiderSex()
    func buiderSkinColour()
    func getRole() -> Role
}
class Director {
    var buider: AbstractBuilder
    init(_ buider:AbstractBuilder) {
        self.buider = buider
    }
    func construct() -> Role {
        buider.buiderName()
        buider.buiderSex()
        buider.buiderSkinColour()
        return buider.getRole()
    }
}

class BlackBuilder: AbstractBuilder {
    var role: Role
    init() {
        self.role = Role()
    }
    func buiderName() {
        role.name = "Jack Ma"
    }
    
    func buiderSex() {
        role.sex = "man"
    }
    
    func buiderSkinColour() {
        role.skinColour = "Black"
    }
    
    func getRole() -> Role {
        return self.role
    }
}
