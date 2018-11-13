# SwiftDesignPattern

>Swift4.2 设计模式 
>
*  **为什么要做这个？**  
	* 学习swift
	* 理解并思考设计模式在swift中的应用方式
	* 参考书籍为《图解设计模式》 - 结城浩 该书为java实现,购买时请注意
	* 关于这本书,是我看过的最好的一本讲解设计模式的书,每一个模式都是独立Demo,而且特征表现完整,所以大部分模式的实现,都是尽量翻版该书用swift来实现,主要的实施难点在于抽象类的实现,有些模式中的抽象类的实现都不太相同,目前在复合模式中是我认为最优的实现,保留了协议函数填充,可选协议函数,函数的抽象调用,尽力的避免SR-103的问题
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
	* 行为型
		* 迭代器 - Iterator
		* 模版方法 - TemplateMethod
		* 策略 - Strategy
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
> 
