# SwiftDesignPattern

>Swift4.2 设计模式 
>
*  **为什么要做这个？**  
	* 学习swift
	* 理解并思考设计模式在swift中的应用方式
	* 参考书籍为《图解设计模式》 - 结城浩
*  **已实现的设计模式**
	* 创建型 
		* 原型 - Prototype 
		* 工厂 - Factory 
		* 抽象工厂 - AbstractFactory 
		* 生成器 - Builder 
		* 单例 - SingletonClass
	* 结构型
		* 适配器 - Adapter 
	* 行为型
		* 迭代器 - Iterator
		* 模版方法 - TemplateMethod
*  **需要注意的地方**
	*  Bug:SR-103
		*  在抽象工厂模式中,使用 protocol.extension 实现抽象类可选方法时,使用中会出现Bug,目前只能通过显示的声明在一级遵守协议类中,才可以在子类中正确的重写,或者弃用protocol.extension方式,通过typealias进行组合实现
		*  通常来说模版模式只有一级类,所以只要保证只有一级类,该写法就可以正确的应用在模版方法模式中

> 
