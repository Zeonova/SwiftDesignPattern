//
//  Decorator.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/13.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
//  装饰模式

import Foundation


protocol AbstractDisplay {
    func getColumns() -> Int
    func getRows() -> Int
    func getRowText(row:Int) -> String
}
class Border {
    var display:AbstractDisplay
    init(_ d: AbstractDisplay) {
        self.display = d
    }
}
extension AbstractDisplay {
    func show() {
        for i in 0..<getRows() {
            print(getRowText(row: i))
        }
    }
}

typealias BorderDisplay = Border & AbstractDisplay

class SideBorder: BorderDisplay {
    private var border:String
    init(_ d:AbstractDisplay, ch:String) {
        self.border = ch
        super.init(d)
    }
    
    func getColumns() -> Int {
        return 1 + display.getColumns() + 1
    }
    
    func getRows() -> Int {
        return display.getRows()
    }
    
    func getRowText(row: Int) -> String {
        return border + display.getRowText(row:row) + border
    }
}
class FullBorder: BorderDisplay {
    func getColumns() -> Int {
        return 1 + display.getColumns() + 1
    }
    
    func getRows() -> Int {
        return 1 + display.getRows() + 1
    }
    
    func getRowText(row: Int) -> String {
        if row == 0 {
            return "+" + makeLine(ch: "_", count: display.getColumns()) + "+"
        } else if (row == display.getRows() + 1) {                      // 下边框
            return "+" + makeLine(ch: "-", count: display.getColumns()) + "+";
        } else {                                                        // 其他边框
            return "|" + display.getRowText(row: row - 1) + "|";
        }
    }
    func makeLine(ch:String, count:Int) -> String {
        var buf = ""
        for _ in 0..<count {
            buf.append(ch)
        }
        return buf
    }
}

class StringDisplay: AbstractDisplay {
    private var text:String
    init(_ t:String) {
        text = t
    }
    func getColumns() -> Int {
        return text.count
    }
    func getRows() -> Int {
        return 1
    }
    func getRowText(row: Int) -> String {
        if row == 0 {
            return text
        }
        return ""
    }
}
extension AbstractDisplay{
    func fullBorder() -> AbstractDisplay {
        return FullBorder(self)
    }
    func sideBorder(ch:String) -> AbstractDisplay {
        return SideBorder(self, ch: ch)
    }
}
