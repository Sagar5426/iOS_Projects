import UIKit

// adding two numbers
func addTwoNum(a:Int,b:Int) -> Int{
    return a+b
}

print(addTwoNum(a: 5, b: 3))

// comaparing two numbers
func compareTwoNum(a:Int,b:Int)-> Void{
    if(a>b){
        print("a is greater")}
    else{
        print("b is greater")
    }
}

compareTwoNum(a: 5, b: 8)

// altering the boolean
func trueOrFalse(a:Bool)->Bool{
    if(a==true){
        return false
    }
    else{
        return true
    }
}
trueOrFalse(a: false)

func isUpperCase(_ str: String) -> Bool{
    str == str.uppercased()
}

let str = "HELLO"
let result = isUpperCase(str)
