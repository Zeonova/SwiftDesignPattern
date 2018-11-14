//
//  Visitor.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/14.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  访问者模式
import Foundation

protocol AbstractVisitor {
    func visit(_ x:File)
    func visit(_ d:Directory)
}
protocol Element {
    func accept(v:AbstractVisitor)
    func enumerable() -> [Entry]?
}
extension File:Element{
    func accept(v: AbstractVisitor) {
        v.visit(self)
    }
    func enumerable() -> [Entry]? {
        return nil
    }
}
// 扩展无法访问到私有 所以一开始要注意到是否要为私有变量提供Get方法
extension Directory:Element{
    func accept(v: AbstractVisitor) {
        v.visit(self)
    }
    func enumerable() -> [Entry]? {
        return getDirectory()
    }
}

class ListVisitor: AbstractVisitor {
    private var currentdir  = ""
    func visit(_ x: File) {
        print(currentdir + "/" + x.toString())
    }
    func visit(_ d: Directory) {
        print(currentdir + "/" + d.toString())
        let savedir = currentdir
        currentdir = currentdir + "/" + d.getName()
        for item in d.getDirectory() {
            if let t = item as? Directory{
                t.accept(v: self)
            }
        }
        currentdir = savedir
    }
}
