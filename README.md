# SwiftDesignPattern

>Swift4.2 设计模式 
>
*  **为什么要做这个？**  
	* 学习swift
	* 理解并思考设计模式在swift中的应用方式
	* 参考书籍为《图解设计模式》 - 结城浩 该书为java实现,购买时请注意
	* 关于这本书,是我看过的最好的一本讲解设计模式的书,每一个模式都是独立Demo,而且特征表现完整,所以大部分模式的实现,都是尽量翻版该书用swift来实现
	* 主要的实施难点在于抽象类的实现,有些模式中的抽象类的实现都不太相同,目前在复合模式中是我认为最优的实现,保留了协议函数填充,可选协议函数,函数的抽象调用,尽力的避免SR-103的问题
*  **已实现的设计模式**
	* 创建型 
		* 原型 - Prototype 
		* 工厂 - Factory 
		* 抽象工厂 - AbstractFactory 
		* 生成器 - Builder 
		* 单例 - SingletonClass
	* 结构型
		* 适配器 - Adapter
		* 桥接 - Bridge 
		* 复合模式 ~~组合模式~~ - Composite
		* 装饰器 - Decorator
		* 外观模式 - Facade
	* 行为型
		* 迭代器 - Iterator
		* 模版方法 - TemplateMethod
		* 策略 - Strategy
		* 访问者 - Visitor
		* 责任链 - ChainOfResponsibility
*  **需要注意的地方**
	*  Bug:SR-103
		*  在抽象工厂模式中,使用 protocol.extension 实现抽象类可选方法时,使用中会出现Bug,目前只能通过显式的声明在一级遵守协议类中,才可以在子类中正确的重写,或者弃用protocol.extension方式,通过typealias进行组合实现
		*  通常来说模版模式只有一级类,所以只要保证只有一级类,该写法就可以正确的应用在模版方法模式中
	* 关于复合模式
		* 通行的名称为组合模式,参考书也没有给出明确模式称呼,所以我采用了复合模式的名称,因为组合模式这个名称,字面理解很容易误解为 A + B = C,实际上该模式表现的是 A + a = A.a
	* 关于抽象类的实现
		* 由于SR-103的问题, 实现抽象类的目前最优方案为 
		* typealias abstract = protocol & class
		* protocol + class + extension protocol :class
		* 注意点:如果要实现可选协议函数,绝不在 extension 实现 protocol 声明的函数, 而是交由未遵守该协议的class来实现, extension 中采用泛型来引入相关类,即可实现调用类的函数
		* 具体的实现可以参考复合模式的代码
	* 关于装饰模式的实现
		* 原书中的生成方式A(B(C(D()))),过于难以阅读,调整为了链式调用A().B().C(),对于这个模式的实现,链式调用应该也要归纳进去
	* 关于访问者模式的实现
		* 例子使用访问者模式来处理复合模式中的数据结构
		* 由于swift.extension 无法进行重写,所以扩展用在了每个具体类,没有对抽象类使用
		* 基于swift.extension 基本可以不需要在修改复合模式代码的情况下就可以完成访问者模式的实现
		* 唯一一处修改是因为没有预留获取Directory类的私有数组的函数
		* 思考:在使用私有修饰变量时,一定要考虑是否要预留对外只读函数
		* swift.extension 是对开闭原则OCP的更好的支持
		* ```element.accept(visitor)```
		* ```visitor.visit(element)```
		* 这种由双方共同决定实际处理的分发方式一般被称为双重分发
	* 实践中发现的一些有趣的写法
		* ```for (int i = 0; i < 500; i += 33)``` 
		* ```for i in stride(from: 0, to: 500, by: 33) {}``` swift
		
		
> 
