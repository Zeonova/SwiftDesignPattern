//
//  AbstractFactory.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/27.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

// 抽象工厂模式，提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类

// 抽象工厂的概念和工厂方法最大区别在于，抽象工厂是复数具体工厂的集合，而且隔离了具体类的生成
// 如果更换了具体工厂的实例，就可以改变整体的行为
// 高内聚低耦合

// 配置: 抽象工厂/具体工厂/抽象产品/具体产品
import Foundation

protocol AbstractFactoryOmegaProtocol {
    func creatAlpha() -> AbstractProductAlphaProtocol
    func creatBeta() -> AbstractProductBetaProtocol
}
protocol AbstractProductAlphaProtocol {
    var title:String { get set }
    func alpha()
}
protocol AbstractProductBetaProtocol {
    var name:String { get set }
    func beta()
}
class AbstractFactory {
    required init() {
    }
    final func creatFactory<T>(subclass: T.Type) -> T? where T : AbstractFactory, T : AbstractFactoryOmegaProtocol {
        return subclass.init()
    }
}




class ConcreteFactoryMu:AbstractFactory, AbstractFactoryOmegaProtocol {
    
    var t = "<MU>"
    func creatAlpha() -> AbstractProductAlphaProtocol {
        return ProductAlpha_A(t)
    }
    
    func creatBeta() -> AbstractProductBetaProtocol {
        return ProductBeta_A(t)
    }
    
    
}

class ConcreteFactoryNu:AbstractFactory, AbstractFactoryOmegaProtocol {
    
    func creatAlpha() -> AbstractProductAlphaProtocol {
        return ProductAlpha_A("Nu-A")

    }
    
    func creatBeta() -> AbstractProductBetaProtocol {
        return ProductBeta_A("Nu-B")
    }
}



class ProductAlpha_A: AbstractProductAlphaProtocol {
    var title: String = ""
    init(_ t:String) {
        title = t
    }
    func alpha() {
        print("hello alpha \(title)")
    }
}


class ProductBeta_A: AbstractProductBetaProtocol {
    var name: String = ""
    init(_ t:String) {
        name = t
    }
    func beta() {
        print("hello beta \(name)")
    }
}
