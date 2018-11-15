//
//  Mediator.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/15.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  中介者模式
//  原书例子中是GUI程序,无非复现在该工程中,只能简单通过输出模拟
import Foundation

// 仲裁者
protocol Mediator {
    func createColleagues()
    func colleagueChanged()
}

// 组员
protocol Colleague {
    func setMediator(mediator:Mediator)
    func setColleagueEnabled(enabled:Bool)
}


class ColleagueA: Colleague {
    private var mediator:Mediator?
    private( set ) var state:Bool?
    func setMediator(mediator: Mediator) {
        self.mediator = mediator
    }
    func setColleagueEnabled(enabled: Bool) {
        state = enabled
        print("ColleagueA is changed" + String(enabled))
    }
}

class ColleagueB: Colleague {
    private var mediator:Mediator?
    private( set ) var state:Bool?
    var textCount:Int = 0 {
        didSet{
            stateChanged()
        }
    }
    func setMediator(mediator: Mediator) {
        self.mediator = mediator
    }
    func setColleagueEnabled(enabled: Bool) {
        state = enabled
        print("ColleagueB is changed" + String(enabled))
    }
    func stateChanged(){
        mediator?.colleagueChanged()
    }
}

// 具体仲裁者

class ConcreteMediator: Mediator {
    private var cA:ColleagueA?
    private var cB:ColleagueB?
    init() {
        createColleagues()
    }
    func createColleagues() {
        self.cA = ColleagueA()
        self.cB = ColleagueB()
        cA?.setMediator(mediator: self)
        cB?.setMediator(mediator: self)
    }
    
    func colleagueChanged() {
        print("textCout is \((cB?.textCount)!)")
        if (cB?.textCount)! % 2 == 0 {
            cA?.setColleagueEnabled(enabled: true)
            cB?.setColleagueEnabled(enabled: true)
        }else{
            cA?.setColleagueEnabled(enabled: false)
            cB?.setColleagueEnabled(enabled: false)
        }
    }
    
    // 模拟输入操作
    func inputText(n:Int) {
        cB?.textCount = n
    }
}
