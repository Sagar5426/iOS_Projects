import UIKit

var myName:String?

myName?.uppercased()

var myAge = "5"

// ?? 0 is a default value
//var myInteger = (Int(myAge) ?? 0)*5

if let myNumber = Int(myAge){
    print(myNumber*5)
}
else{
    print("Wrong Input")
}







