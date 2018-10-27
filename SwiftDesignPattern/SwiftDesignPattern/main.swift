//
//  main.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/26.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

import Foundation


var a = TestClassSub()
var b = a.copy()
b.data = 1
print(b.data)
print(a.data)


var c = TestStruct()
var d = c

//用于打印结构内存地址的函数
withUnsafePointer(to: &c) {print($0)}
withUnsafePointer(to: &d) {print($0)}

print(c,d)


var t = SuperClass()
t.doSomething()

var f = SuperClass.loadSubClass(subclass: SubclassA.self)
f!.doSomething()



var asbSuperClass =  AbstractSuperClass.loadSubClasForSuperType(subclass: SubAbsClassA.self)
var asbSuperOtherClass =  AbstractSuperClass.loadSubClasForSuperType(subclass: SubAbsClassB.self)

asbSuperClass?.doit()
asbSuperOtherClass?.doit()
