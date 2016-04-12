//: Playground - noun: a place where people can play

import UIKit

// >> 方法？
/*
    方法就是函数,只是这个函数与某个类型相关联了
    方法是与某些特定类型相关联的函数。

    类、结构体、枚举都可以定义实例方法;实例方法为给定类型的实例封装 了具体的任务与功能。

    类、结构体、枚举也可以定义类型方法;类型方法与类型本身相关联。
    类型方法与 Object ive-C 中的类方法(class methods)相似。
*/



// >> 实例方法？
/*
    例方法是属于某个特定类、结构体或者枚举类型实例的方法。
    实例方法提供访问和修改实例属性的方法或提供
    与实例目的相关的功能,并以此来支撑实例的功能。


    实例方法要写在它所属的类型的前后大括号之间。
    实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。
    实例方法只能被它所属的类的某个特定实例调用。
    实例方法不能脱离于现存的实例而被调用
*/

class Counter {
    var count = 0
    
    func increment() { // 递增
        ++count
    }
    
    func incrementBy(amount: Int) { // amount ： 增量
        count += amount
    }
    
    func reset() {
        count = 0
    }

}

let counter = Counter()
print("count = \(counter.count)")

counter.increment()
print("count = \(counter.count)")

counter.incrementBy(4)
print("count = \(counter.count)")

counter.reset()
print("count = \(counter.count)")




// >> 方法的局部参数 和 外部参数

/*
    函数参数可以同时有一个局部名称(在函数体内部使用)和一个外部名称(在调用函数时使用)

    Swift 默认仅给方法的第一个参数名称一个局部参数名称;
    默认同时给第二个和后续的参数名称局部 参数名称和外部参数名称。这个约定与典型的命名和调用约定相适应
*/

extension Counter {
    // amount 是一个局部变量，也就是调用方法时不能写 amount
    // numberOfTimes, 默认即看作局部名称又看作外部名称
    func incrementBy(amount: Int,  numberOfTimes: Int){
        count += amount * numberOfTimes
    }
}
 // counter.incrementBy(amount:8, numberOfTimes: 3)  // error
counter.incrementBy(8, numberOfTimes: 3)

/*
    不必为第一个参数值再定义一个外部变量名:因为从函数名 incrementBy(_numberOfTimes:) 已经能很清楚地看 出它的作用。
    但是第二个参数,就要被一个外部参数名称所限定,以便在方法被调用时明确它的作用。
    这种默认行为使上面代码意味着:在 Swift 中定义方法使用了与 Objective-C 同样的语法风格,并且方法将以 自然表达式的方式被调用。
*/



// >> 修改方法的外部参数名称
/*
有时为方法的第一个参数提供一个外部参数名称是非常有用的,尽管这不是默认的行为。你可以自己添加一个显
式的外部名称作为第一个参数的前缀来把这个局部名称当作外部名称使用。
相反,如果你不想为方法的第二个及后续的参数提供一个外部名称,可以通过使用下划线( _ )作为该参数的显 式外部名称,这样做将覆盖默认行为。
*/

extension Counter {
    func minusBy(multiplier amount: Int, _ multiplicand: Int){
        count -= amount * multiplicand
    }
}

counter.minusBy(multiplier: 3, 5)



// >> self 属性

/*
    类型的每一个实例都有一个隐含属性叫做 self , self 完全等同于该实例本身。
    你可以在一个实例的实例方法中 使用这个隐含的 self 属性来引用当前实例。

    func increment() {
        self.count++
    }


    实际上,你不必在你的代码里面经常写 self 。
    不论何时,只要在一个方法中使用一个已知的属性或者方法名 称,如果你没有明确的写 self ,Swift 假定你是指当前实例的属性或者方法


    使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。
    在这种情况下,参数名 称享有优先权,并且在引用属性时必须使用一种更严格的方式。
    这时你可以使用 self 属性来区分参数名称和属性 名称。


*/

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        // 如果不使用 self 前缀,Swift 就认为两次使用的 x 都指的是名称为 x 的函数参数
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}


// >> 在实例方法中修改值类型
/*
    结构体和枚举是值类型。一般情况下,值类型的属性不能在它的实例方法中被修改。
    但是,如果你确实需要在某个具体的方法中修改结构体或者枚举的属性,你可以选择 变异(mutating) 这个方法,然后方法就可以从方法内部改变它的属性;并且它做的任何改变在方法结束时还会保留在原始结构中。
    方法 还可以给它隐含的 self 属性赋值一个全新的实例,这个新实例在方法结束后将替换原来的实例。
*/
struct Point1 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    // 可变方法能够赋给隐含属性 self 一个全新的实例
    mutating func moveTo(x: Double, y: Double){
        self = Point1(x: x, y: y)
    }
}
var somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint1.x), \(somePoint1.y))")

// 注意:不能在结构体类型常量上调用可变方法,因为常量的属性不能被改变,即使想改变的是常量的变量属性也不行
let fixedPoint = Point1(x: 3.0, y: 3.0)
// fixedPoint.moveByX(2.0, y: 3.0) // error



// 枚举的可变方法可以把 self 设置为相同的枚举类型中不同的成员
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()



// >> 类型方法

/*
    你也可以定义类型本身调用的方法,这种方法就叫做类型方法。
    声明 结构体和枚举的类型方法,在方法的 func 关键字之前加上关键字 static 。
    类可以用关键字 class 来允许子类 重写父类的实现方法。static 表示不能被子类重载

    类型方法和实例方法一样用点语法调用。
    但是,你是在类型层面上调用这个方法,而不是在实例层面上调用。
*/


class OneTypeClass {
    static func oneTypeMethod(){
        // self :在类型方法中, self 指向这个类型本身,而不是类型的某个实例。对于结构体和枚举来说,这 意味着你可以用 self 来消除静态属性和静态方法参数之间的歧义(类似于我们在前面处理实例属性和实例方法参 数时做的那样)。
        print(self)
    }
}
// 类型方法调用
OneTypeClass.oneTypeMethod()



/*
    一般来说,任何未限定的方法和属性名称,将会来自于本类中另外的类型级别的方法和属性。
    一个类型方法可以调用本类中另一个类型方法的名称,而无需在方法名称前面加上类型名称的前缀。
    同样,结构体和枚举的类型方法也能够直接通过静态属性的名称访问静态属性,而不需要类型名称前缀。
*/


struct LevelTracker {
    static var highestUnlockedLevel = 1 // 所有实例的最高关卡
    
    static func unlockLevel(level: Int) { // 解锁 level 关卡
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool { // 判断一个关卡是否解锁
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1 // 一个实例的 当前关卡
    
    mutating func advanceToLevel(level: Int) -> Bool { // 跟新关卡
        if LevelTracker.levelIsUnlocked(level) { // 若解锁 更新 currentLevel
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func completedLevel(level: Int){ // 完成一个关卡
        LevelTracker.unlockLevel(level + 1) // 解锁下一个关卡
        tracker.advanceToLevel(level + 1)
    }
    
    init(name: String){
        playerName = name
    }
}


var player1 = Player(name: "player1")
player1.completedLevel(1) // 完成关卡1
print("highest unlocker level is \(LevelTracker.highestUnlockedLevel)")



var player2 = Player(name: "player2")
if player2.tracker.advanceToLevel(6) {
    print("player2 is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

print("player1 current level = \(player1.tracker.currentLevel)")
print("player2 current level = \(player2.tracker.currentLevel)")

player2.completedLevel(8)
print("highest unlocker level is \(LevelTracker.highestUnlockedLevel)")
print("player1 current level = \(player1.tracker.currentLevel)")
print("player2 current level = \(player2.tracker.currentLevel)")



