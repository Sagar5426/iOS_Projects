import UIKit

var isSaved = true
isSaved.toggle()

let employee = [
    "name":"Sagar",
    "age":"19 years old"]
print("Employee name is \( employee["name"] ?? "name") and age is \( employee["age"] ?? "0")")

let naturalNumber = Set([1,2,3,4,2,3,1,1,5])
print(naturalNumber)

let pi : Double = 3.14
print(type(of: pi))

//var colors : Array<String> = ["Red","Yellow","Green"]
// shorter way to write
var colors : [String] = ["Red","Yellow","Green"]
//var user : Dictionary<String,Int> = ["User1":123456,"User2":111111]
var user : [String:Int] = ["User1":123456,"User2":111111]

var emptyArray = [String]()

enum UIStyle{
    case light, dark, system
}

func printTable(number:Int) -> Void{
    for i in 1..<11{
        print("\(number) X \(i) = \(number*i)")
    }
}
printTable(number: 5)

func rollDice() -> Int{
    Int.random(in: 1...6)   // can remove 'return' keyword bcz a single line is written here
}
