//
//  Strategy.swift
//  SwiftDesignPattern
//
//  Created by zhangwei on 2018/11/12.
//  Copyright © 2018年 Mr.Z. All rights reserved.
//
// 策略模式
// 角色: 抽象策略/具体策略/策略使用者

import Foundation

// 手势类 策略目标
class Hand {
    // 石头0 剪刀1 布2
    enum HandValue:Int {
        case guu = 0
        case cho
        case paa
    }
    static let hands = [Hand(HandValue.guu),
                        Hand(HandValue.cho),
                        Hand(HandValue.paa)]
    static let name = ["石头","剪刀","布"]
    private var handValue:HandValue
    private init(_ value:HandValue) {
        self.handValue = value
    }
    static func getHand(value:HandValue) -> Hand{
        return hands[value.rawValue]
    }
    func isStrongerThan(h:Hand) -> Bool {
        return fight(h) == 1
    }
    func isWeakerThan(h:Hand) -> Bool {
        return fight(h) == -1
    }
    func toString() -> String {
        return Hand.name[self.handValue.rawValue]
    }
    
    //（self.handValue.rawValue + 1) % 3 == h.handValue.rawValue
    // 这里代码需要配合枚举表思考,两个相邻的手势，总是前一个赢
    // 实际上这个表应该是 0/1/2/0, 通过取余巧妙的确保2的下一位是0
    /// 平:0 胜:1 负:-1
    private func fight(_ h:Hand) -> Int{
        if self.handValue == h.handValue {
            return 0
        }else if (self.handValue.rawValue + 1) % 3 == h.handValue.rawValue {
            return 1
        }else{
            return -1
        }
    }
}

// 抽象策略
protocol Strategy {
    func nextHand() -> Hand
    func study(win:Bool)
}
// 赢了继续出的策略
class WinningStrategy: Strategy {
    private var won:Bool = false
    private var prevHand:Hand?
    func nextHand() -> Hand {
        if !won {
            prevHand = Hand.getHand(value: Hand.HandValue(rawValue: Int.random(in: 0...2))!)
        }
        return prevHand!
    }
    
    func study(win: Bool) {
        won = win
    }
}

// 计算概率的策略
class ProbStrategy: Strategy {
    private var prevHandValue = Hand.HandValue.guu
    private var currentHandValue = Hand.HandValue.guu
    
    // history[prevHandValue][currentHandValue]
    // 指上一局的手势和这一句的手势的胜次
    private var history:[[Int]] = [
        [1,1,1],
        [1,1,1],
        [1,1,1]
    ]
    func nextHand() -> Hand {
        let bet = Int.random(in: 0..<getSum(currentHandValue.rawValue))
        var handValue = 0
        if (bet < history[currentHandValue.rawValue][0]) {
            handValue = 0;
        } else if (bet < history[currentHandValue.rawValue][0] + history[currentHandValue.rawValue][1]) {
            handValue = 1;
        } else {
            handValue = 2;
        }
        prevHandValue = currentHandValue;
        currentHandValue = Hand.HandValue(rawValue: handValue)!
        return Hand.getHand(value: currentHandValue)
    }
    
    func study(win: Bool) {
        if (win) {
            history[prevHandValue.rawValue][currentHandValue.rawValue] += 1
        } else {
            history[prevHandValue.rawValue][(currentHandValue.rawValue + 1) % 3] += 1
            history[prevHandValue.rawValue][(currentHandValue.rawValue + 2) % 3] += 1
        }
    }
    private func getSum(_ hv:Int) -> Int {
        var sum = 0
        for i in 0..<3 {
            sum += history[hv][i]
        }
        return sum
    }
}

// 愚蠢策略 只出一个手势
class IdiotStrategy: Strategy {
    var hand = Hand.getHand(value: Hand.HandValue(rawValue: Int.random(in: 0...2))!)
    func nextHand() -> Hand {
        return hand
    }
    func study(win: Bool) {
        print("not study")
    }
}



// 策略实施者
class Player {
    var name:String
    private var strategy:Strategy
    private var wincount:Int = 0
    private var losecount:Int = 0
    private var gamecount:Int = 0
    
    init(name:String, strategy:Strategy) {
        self.name = name
        self.strategy = strategy
    }
    func nextHand() -> Hand {
        return strategy.nextHand()
    }
    func win() {
        strategy.study(win: true)
        wincount += 1
        gamecount += 1
    }
    func lose() {
        strategy.study(win: false)
        losecount += 1
        gamecount += 1
    }
    func even() {
        gamecount += 1
    }
    func toString() -> String {
        return "[\(name):\(gamecount) games, \(wincount)win \(losecount)lose]"
    }
}
