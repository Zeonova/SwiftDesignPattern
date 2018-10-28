//
//  Builder.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/28.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 生成器模式：将一个复杂对象的构建与它的表现分离，使得同样的构建过程可以创建不同的表现


//                  生成器和抽象工厂的差异为
//      生成器                               抽象工厂
//    构建复杂对象                         构建简单或复杂对象
//    以多个步骤构建对象                    以单一步骤构建对象
//    以多种方式构建对象                    以单一方式构建对象
// 在构建过程的最后一步返回产品                 立刻返回产品
//   专注一个特定的产品                      强调一套产品

// 个人见解:我认为生成器模式，是需要三个部分组成，原料 指导 生成，网上很多例子都是缺少原料这个部分，不管怎么看都像是和抽象工厂模式弄混了
// 生成器最关键的地方在于定制，也是要有原料，再根据一定的要求，进行定制
// 例如，原料（钢铁） 要求（汽车） 生产出一辆没有任何橡胶部件（没有轮子或者是钢铁轮子）的汽车

import Foundation

// 原料
// 个人理解:get方法最好放在原料类，这样才是最好的实现生成器模式
// 在swift中不需要引入头文件，但是在OC中，将get放置在原料中，是最好的做法，外部类，不要关心它不该操心的东西
// 只需设定好值，然后，操作构建好的对象就行
class Material {
    var type:Int = 0
    var rank:Int = 0
    var money:Int = 0
    
    func get() -> AbstractBuildProtocol {
        return Director.build(meterial: self)
    }
}

// 抽象生成器对象
// 个人见解:这部分是生成器对象应该具备的部分，而不是用做生成步骤
// 从模式的定义和设计上来说，生成器模式，实际上并不关心每个生成器的生成步骤，而是希望它们有相同的对象行为
// 所以，我按我的理解，将此层作为了行为协议，而具体生成步骤，交给了每个生成器的具体实现类
// 这样才更符合生成器的设计定义
protocol AbstractBuildProtocol {
    func hello()
}

// 指导者，用于控制原料进入哪个生成流程，本例子用原料中的type进行控制
class Director {
    static func build(meterial:Material) -> AbstractBuildProtocol {
        switch meterial.type {
        case 1:
            return BuildMissile(material: meterial)
        default:
            return BuildCar(material: meterial)
        }
    }
}

// 具体生成器
class BuildCar: AbstractBuildProtocol {
    var str:String = ""
    init(material:Material) {
        if material.rank > 5 {
            self.str = "Super"
        }
        switch material.money {
        case 0..<100:
            self.str += "BabyTrike"
        case 100..<1000:
            self.str += "FordCar"
        default:
            self.str += "MASERATICar"
        }
    }
    
    func hello() {
        print(str)
    }
}

class BuildMissile: AbstractBuildProtocol {
    init(material:Material) {
        print("No Way")
    }
    func hello() {
        print("FBI open the door")
    }
}
