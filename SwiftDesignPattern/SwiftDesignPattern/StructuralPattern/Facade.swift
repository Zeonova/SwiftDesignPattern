//
//  Facade.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/15.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  外观模式
import Foundation
// 模拟数据

fileprivate class Database {
    private init(){
        
    }
    static func getProperties(file:String) -> Dictionary<String, String>{
        return [
            "Hiroshi Yuki":"hyuki@hyuki.com",
            "Hanako Sato":"hanako@hyuki.com",
            "Tomura":"tomura@hyuki.com",
            "Mamoru Takahashi":"mamoru@hyuki.com"
        ]
    }
}

fileprivate class HtmlWriter {
    private var content:String = ""
    func title(_ t:String) {
        content += "<html>"
        content += "<head>"
        content += "<title>" + t + "</title>"
        content += "</head>"
        content += "<body>\n"
        content += "<h1>" + t + "</h1>\n"
    }
    func paragraph(_ msg:String) {
        content += "<p>" + msg + "</p>"
    }
    func link(href:String, caption:String) {
        paragraph("<a href=\"" + href + "\">" + caption + "</a>")
    }
    func mailto(_ mailaddr:String,_ name:String) {
        link(href: "mailto:" + mailaddr, caption: name)
    }
    func close() {
        content += "</body>"
        content += "</html>\n"
        print(content)
    }
}

class PageMaker {
    private init(){}
    
    static func makeWelcomePage(mailaddr:String, fileName:String)
    {
        let dict = Database.getProperties(file: fileName)
        var userName = "Mr.x"
        for (key,value) in dict {
            if value == mailaddr {
                userName = key
            }else if key == mailaddr {
                userName = value
            }
        }
        let htmlWriter = HtmlWriter()
        htmlWriter.title("Welcome to" + userName + "'s page!")
        htmlWriter.paragraph("欢迎来到" + userName + "的主页")
        htmlWriter.paragraph("等值你的邮件哦")
        htmlWriter.mailto(mailaddr, userName)
        htmlWriter.close()
    }
}
