//
//  Interpreter.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/18.
//  Copyright © 2018年 Mr.Z. All rights reserved.

//  解释器模式
//  语法规则也是类
//  用迷你语言写的迷你程序,被解释器执行

//  Backus-Naur Form | Backus Normal Form
//  EBNF
//
/*
    1.  <program> ::= program <command list>
    2.  <command list> ::=  <command> * end
    3.  <command> ::= <repeat command> | <primitive command>
    4.  <repeat command> ::= repeat <number> <command list>
    5.  <primitive command> ::= go | right | left
 */
//  <primitive command> Terminal Expression 终结符表达式 语法规则的终点

import Foundation


protocol Node {
    func parse(context:Context)
}


// <program> ::= program <command list>
class ProgramNode: Node {
    private var commandListNode:Node?
    func parse(context: Context) {
        context.skipToken(token: "program")
        commandListNode = CommandListNode()
        commandListNode?.parse(context: context)
    }
}
// <command list> ::=  <command> * end
// *指重复0次以上的command,以end结束
class CommandListNode: Node {
    private( set ) var list:[CommandNode] = []
    func parse(context: Context) {
        while true {
            if context.currentToken == nil{
                // 报错
                preconditionFailure("parse Exception")
            }else if context.currentToken == "end"{
                context.skipToken(token: "end")
                break
            }else{
                let commandNode = CommandNode()
                commandNode.parse(context: context)
                list.append(commandNode)
            }
        }
    }
}
// <command> ::= <repeat command> | <primitive command>
// 可能是repeat 或者是 primitive
class CommandNode: Node {
    private( set ) var node:Node?
    func parse(context: Context) {
        if context.currentToken == "repeat" {
            node = RepeatCommandNode()
            node?.parse(context: context)
        }else {
            node = PrimitiveCommandNode()
            node?.parse(context: context)
        }
    }
}

// <repeat command> ::= repeat <number> <command list>
// number 的定义被省略掉了，指的12345自然数
// 这里是在递归到了 <command list> ,看起来是死循环,其实一定会结束于 终结符表达式, 如果没有，那么一定是语法描述有问题

class RepeatCommandNode: Node {
    private( set ) var number:Int?
    private( set ) var commandListNode:Node?
    func parse(context: Context) {
        context.skipToken(token: "repeat")
        number = context.currentNumber()
        _ = context.nextToken()
        commandListNode = CommandListNode()
        commandListNode?.parse(context: context)
    }
}
// <primitive command> ::= go | right | left
class PrimitiveCommandNode: Node {
    func parse(context: Context) {
        if let name = context.currentToken {
            context.skipToken(token: name)
            let method:Set<String> = ["go","right","left"]
            if !method.contains(name){
                preconditionFailure("name undefined")
            }else{
                print(name)
            }
        }
    }
}

class Context {
    private( set ) var tokens:[String]?
    private( set ) var text:String
    private( set ) var currentToken:String?
    init(_ text:String) {
        self.text = text
        tokens = tokenizer(text: text)
        _ = nextToken()
    }
    func nextToken() -> String?{
        if (tokens?.isEmpty)! {
            return nil
        }else{
            currentToken = tokens?.first
            tokens?.remove(at: 0)
            return currentToken
        }
    }
    
    func skipToken(token:String) {
        if token == currentToken {
            _ = nextToken()
        }else{
            preconditionFailure("Warning !!!")
        }
    }
    
    func currentNumber() -> Int? {
        return Int(currentToken ?? "0")
    }
}

// 分词器扩展
extension Context {
    func tokenizer(text:String) -> [String]{
        var tokens = [String]()
        let ref = CFStringTokenizerCreate(kCFAllocatorDefault, text as CFString, CFRangeMake(0, text.count), CFOptionFlags(kCFStringTokenizerUnitWord), CFLocaleCopyCurrent())
        var tknType = CFStringTokenizerAdvanceToNextToken(ref)
        let startIndex = text.startIndex
        while tknType.rawValue != 0 {
            let range = CFStringTokenizerGetCurrentTokenRange(ref)
            let from = text.index(startIndex, offsetBy: range.location)
            let to = text.index(from, offsetBy: range.length - 1)
            let temp = text[from...to]
            tokens.append(String(temp))
            tknType = CFStringTokenizerAdvanceToNextToken(ref)
        }
        return tokens
    }
}
