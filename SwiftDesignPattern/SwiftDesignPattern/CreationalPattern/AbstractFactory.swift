//
//  AbstractFactory.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/10/27.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//

// 抽象工厂模式，提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类

// 抽象工厂的概念和工厂方法最大区别在于，抽象工厂是复数相关的具体工厂的集合,以零件组合方式出新的产品
// 如果更换了具体工厂的实例，就可以改变整体的行为
// 高内聚低耦合

// swift中没有抽象类，我采用class和protocol组合的方式来实现，具体表现为泛型的约束

// 配置: 抽象工厂/具体工厂/抽象产品/具体产品
import Foundation
// 抽象工厂类
// typealias 使用别名将类和协议组合成抽象类
typealias AbstractFactoryClass = AbstractFactory & AbstractFactoryOmegaProtocol


protocol AbstractFactoryOmegaProtocol {
    func createLink(caption:String, url:String) -> Link
    func createTray(caption:String) -> Tray
    func createPage(title:String, author:String) -> Page
}
class AbstractFactory {
    required init() {
    }
    static func creatFactory<T>(subclass: T.Type) -> T? where T : AbstractFactoryClass {
        return subclass.init()
    }
}
// 抽象基础零件类
class ItemBase:AbstractItemBase {
    public var caption:String
    init(_ caption:String) {
        self.caption = caption
    }
    func makeHTML() -> String? {
        return nil
    }
}
protocol AbstractItemBase {
    func makeHTML() -> String?
}

// 抽象link零件
class Link: ItemBase {
    var url: String
    init(caption:String, url:String) {
        self.url = url
        super.init(caption) // 在调用父类构造函数之前，必须保证本类的属性都已经完成初始化
    }
}
// 抽象Tray零件
class Tray: ItemBase {
    var tray:[ItemBase] = []
    func add(_ item:ItemBase) {
        tray.append(item)
    }
}
// 抽象page类
class Page:AbstractItemBase {
    var title:String
    var author:String
    var content:[ItemBase]
    
    init(title:String,author:String) {
        self.title = title
        self.author = author
        self.content = []
    }
    func add(_ item:ItemBase){
        content.append(item)
    }
    func output() {
        let fileName = title + ".html"
        print(fileName)
        if let html = self.makeHTML() {
            print(html)
        }
    }
    func makeHTML() -> String? {
        return nil
    }
}

/// ListFactory 将使用内部类来避免暴露零件的实现
class ListFactory:AbstractFactoryClass {
    
    func createLink(caption: String, url: String) -> Link {
        return ListLink(caption: caption, url: url)
    }
    
    func createTray(caption: String) -> Tray {
        return ListTray(caption)
    }
    
    func createPage(title: String, author: String) -> Page {
        return ListPage(title: title, author: author)
    }
    //MARK: - 零件的内部类实现
    class ListLink: Link {
        override func makeHTML() -> String? {
            return "  <li><a href=\"" + url + "\">" + caption + "</a></li>\n"
        }
    }
    
    class ListTray: Tray {
        override func makeHTML() -> String? {
            var buffer = ""
            buffer.append("<li>\n");
            buffer.append(caption + "\n");
            buffer.append("<ul>\n");
            for item in tray {
                if let text = item.makeHTML() {
                    buffer.append(text);
                }
            }
            buffer.append("</ul>\n");
            buffer.append("</li>\n");
            return buffer;
        }
    }
    
    class ListPage: Page {
        override func makeHTML() -> String? {
            var buffer = ""
            buffer.append("<html><head><title>" + title + "</title></head>\n");
            buffer.append("<body>\n");
            buffer.append("<h1>" + title + "</h1>\n");
            buffer.append("<ul>\n");
            for item in content {
                if let text = item.makeHTML() {
                    buffer.append(text);
                }
            }
            buffer.append("</ul>\n");
            buffer.append("<hr><address>" + author + "</address>");
            buffer.append("</body></html>\n");
            return buffer;
        }
    }
    
}
