//
//  Delegate.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/18.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//  委托模式

import Foundation

// 桥接模式的作用是将 类的功能层次结构 和 类的实现层次结构 连接起来
// iOS中的委托模式 即 桥接模式-变种改造型
// 由于是App的运行特征会产生双向持有所以才需要weak来切断循环引用



// 下面是一个假想的UITableview 即 类的功能层次结构
class Nothing {
    // 由于weak关键字不能直接应用在 协议上,所以需要这么一个空类
    // 正如所有的view都有一个基类
}
typealias UITableViewDelegate = AbstractDisplayImpl & Nothing // 桥接模式的协议改了个名字而已
class UITableview{
    weak open var delegate:UITableViewDelegate?
    init() {
    }
    func delegateDisplay() {
        delegate?.rawOpen()
        delegate?.rawPrint()
        delegate?.rawClose()
    }
}
// 讲下面一个类模拟成App某一个view 即 类的实现层次结构
class AppView:UITableViewDelegate{
    var subView:UITableview?
    override init() {
        super.init()
        let b = UITableview()
        b.delegate = self
        self.addSubView(view: b)
    }
    func rawOpen() {
        print("++++++")
    }
    func rawPrint() {
        print("text")
    }
    func rawClose() {
        print("++++++")
    }
    func viewDidAppear(){
        subView?.delegateDisplay()
    }
    func addSubView(view:Any) {
        self.subView = view  as? UITableview
    }
}
