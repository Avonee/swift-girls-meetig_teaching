//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//設定變數 ex:重量
var weight = 30

//如果重量大於等於 50
if weight >= 50{
    
    //執行
     print("我要減肥拉！！！")
}else if weight <= 30{
    
    print("寶寶太瘦了～寶寶要多吃多健康！")
    
}

////設定變數 ex:重量
//var weight = 77

switch weight{


//在0~30或是50~79的條件下
case  0..<31, 50..<80:
    print("健康亮紅燈逼逼叫逼逼叫逼逼叫！！！")
    
default:
    print("健康好寶寶")
    
}


//設置一個點座標（x,y）
let Point = (3, -1)
switch Point {
    
//讓此為一個座標,當 x = y的時候（條件）
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
    
//讓此為一個座標,當 x = -y的時候（條件）
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")

//讓此為一個座標（條件）
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}


while weight == 0{
    print("寶寶太瘦了～寶寶要多吃多健康！")
}

repeat{
    print("健康好寶寶")
    
}while weight == 10

var sum:Int = 0
for number in 1...5{
    sum = sum + number
}
print("\(sum)")





