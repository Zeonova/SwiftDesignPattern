//
//  Command.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/18.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  命令模式
//  命令也是类,将事件或者说操作以类的形式展现

import Foundation

protocol CommandMethod{
    func execute()
}
class CommandClass: Equatable {
    static func == (lhs: CommandClass, rhs: CommandClass) -> Bool {
        return lhs === rhs
    }
}
// 抽象命令
typealias Command = CommandClass & CommandMethod

// 统合命令,该命令的责任管理调度具体执行命令
class MacroCommand: Command {
    private( set ) var commands:[Command] = []
    func execute() {
        for item in commands {
            item.execute()
        }
        print("")
    }
    func add(cmd:Command) {
        if cmd != self {
            commands.append(cmd)
        }
    }
    func undo() {
        if !commands.isEmpty {
            commands.removeLast()
        }
    }
    func clear()  {
        commands.removeAll()
    }
}

// 具体命令
class PrintCommand: Command {
    private var textLog:PrintText
    private( set ) var text:String
    init(_ log:PrintText,text:String) {
        textLog = log
        self.text = text
    }
    func execute() {
        textLog.logText(text: text)
    }
}

protocol PrintText {
    func logText(text:String)
}

class CommandExecuter: PrintText {
    func logText(text: String) {
        print("|===\(text)===|")
    }
}
