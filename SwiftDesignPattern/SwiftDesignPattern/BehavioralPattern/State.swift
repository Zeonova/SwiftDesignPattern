//
//  State.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/16.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//  状态模式
//  角色为:上下文/状态/具体状态
//  将逻辑判断分而治之的方式进行拆分处理,针对状态来编写,再利用中介者模式进行状态控制
//  状态越多,该模式的表现越好
import Foundation

protocol RoboCopContext {
    var  targetID:Int?{get set}
    func generalVoice()
    func combatVoice()
    func checkTarget() -> Bool
    func targetAttack() -> Bool
    func report(msg:String)
}
protocol RoboCopStateAction {
    func say(context:RoboCopContext)
    func targetAction(context:RoboCopContext) -> Bool
    func callCenter(context:RoboCopContext)
}
// 具体上下文
class RoboCopCore: RoboCopContext {
    var targetID:Int?
    func generalVoice() {
        print("巡逻中...")
    }
    
    func combatVoice() {
        print("战斗开始...")
    }
    
    func checkTarget() -> Bool {
        if targetID! % 3 == 0 {
            print("你是个好人...")
            return true
        }
        print("发现通缉犯编号:\(targetID!)")
        return false
    }
    func targetAttack() -> Bool {
        if Bool.random() {
            print("biu biu biu .... 编号:\(self.targetID!) 结束了罪恶的一生...")
            return true
        }else{
            print("编号:\(self.targetID!) 逃跑中...")
            return false
        }
    }
    func report(msg: String) {
        if msg.count != 0 {
            print("连接中...")
            print("连接成功,请报告")
            print(msg)
            print("over")
        }
    }
}
class GeneralState: RoboCopStateAction {
    static let sharedInstance = GeneralState()
    private init(){
        print("巡逻模式激活...")
    }
    
    func say(context: RoboCopContext) {
        context.generalVoice()
    }
    
    func targetAction(context: RoboCopContext) -> Bool {
        return context.checkTarget()
    }
    
    func callCenter(context: RoboCopContext) {
        context.report(msg: "巡逻结束")
    }
}

class CombatState: RoboCopStateAction {
    static let sharedInstance = CombatState()
    private init(){
        print("战斗模式激活...")
    }
    private var text:String?
    
    func say(context: RoboCopContext) {
        context.combatVoice()
    }
    func targetAction(context: RoboCopContext) -> Bool {
        let bool = context.targetAttack()
        if bool {
            text = "目标击毙"
        }else{
            text = "目标丢失,展开追击..."
        }
        return bool
    }
    func callCenter(context: RoboCopContext) {
        context.report(msg: text!)
    }
}

class RoboCop {
    static let sharedInstance = RoboCop()
    private init(){
        print("机械战警出动!")
    }
    let core = RoboCopCore()
    var state:RoboCopStateAction = GeneralState.sharedInstance
    func setTager(id:Int) {
        core.targetID = id
    }
    func begin() {
        state.say(context: core)
        if !state.targetAction(context: core){
            state = CombatState.sharedInstance
            state.say(context: core)
            while !state.targetAction(context: core){
                state.callCenter(context: core)
            }
            print("战斗结束...解除战斗模式")
            state = GeneralState.sharedInstance
        }
        state.callCenter(context: core)
    }
}
