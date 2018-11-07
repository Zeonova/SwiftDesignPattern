//
//  main.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/26.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

import Foundation

func protypeTest(){
    let a = TestClassSub()
    let b = a.copy()
    b.data = 1
    print(b.data)
    print(a.data)
    var c = TestStruct()
    var d = c
    //用于打印结构内存地址的函数
    withUnsafePointer(to: &c) {print($0)}
    withUnsafePointer(to: &d) {print($0)}
    print(c,d)
}


func factoryTest(){
    let t = SuperClass()
    t.doSomething()
    let f = SuperClass.loadSubClass(subclass: SubclassA.self)
    f!.doSomething()
}

func absFactoryTest(){
    let asbSuperClass =  AbstractSuperClass.loadSubClasForSuperType(subclass: SubAbsClassA.self)
    let asbSuperOtherClass =  AbstractSuperClass.loadSubClasForSuperType(subclass: SubAbsClassB.self)
    asbSuperClass?.doit()
    asbSuperOtherClass?.doit()
}

func builderTest(){
    let materia = Material()
    let build = materia.get()
    build.hello()
    
    materia.money = 1000
    materia.rank = 6
    materia.get().hello()
    materia.type = 1
    materia.money = 100000000
    materia.rank = 1
    materia.get().hello()

}

func singletonTest(){
    let a = SingletonObject.sharedInstance
    var s = 0
    for i in 0..<100 {
        DispatchQueue.global().async {
            a.data += 1
            a.data -= 1
            DispatchQueue.main.sync {
                print(a.data)
            }
        }
        DispatchQueue.global().async {
            DispatchQueue.main.sync {
                print(a.data)
            }
        }
        if i % 2 == 0 {
            DispatchQueue(label: "test").async {
                a.data += 1
                s += 1
                DispatchQueue.main.sync {
                    print(">>>>>>\(a.data) \(s)<<<<<<<")
                }
            }
        }
    }
}


func AdapterTest(){
    let a = Adapter()
    a.type = 1
    a.hello()
    a.work()
    a.sleep()
}

AdapterTest()

func runloopTest(){
    // 命令行模式下，需要启动一个runloop才可以保护多线程
    let runLoop = CFRunLoopGetCurrent();
    let runLoopMode = CFRunLoopMode.defaultMode;
    let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,
                                                      CFRunLoopActivity.allActivities.rawValue,
                                                      false, 0) { (server, act) in
                                                        singletonTest()
    }
    CFRunLoopAddObserver(runLoop, observer, runLoopMode);
    CFRunLoopRun()
}



