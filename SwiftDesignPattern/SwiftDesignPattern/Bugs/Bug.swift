//
//  Bug.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/12.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 一些关于 extension 的 bug
import Foundation

protocol TestP {
    func toooo()
    func makeHTML()
}
extension TestP{
    func makeHTML() {
        print("noooo")
    }
}
class TestA: TestP {
    func toooo() {
        print(self)
        makeHTML()
    }
}
class TestB: TestA {
    func makeHTML() {
        print("TestB")
    }
}

protocol Greetable {
    func sayHi()
}
extension Greetable {
    func sayHi() {
        print("Hello")
    }
}
func greetings<T:Greetable> (greeter: T) {
    greeter.sayHi()
}
class Person: Greetable {
}
class LoudPerson: Person {
    func sayHi() {
        print("HELLO")
    }
}

// let a  = TestB().toooo()
// greetings(greeter: LoudPerson())
