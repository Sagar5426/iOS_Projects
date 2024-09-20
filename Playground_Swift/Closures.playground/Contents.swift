import UIKit

//Closures

let sayHello = { (name:String) -> String in
    "Hi \(name)"
}


sayHello("Sagar")

let team = ["Gloria","Suzzane","Tiffany","Tasha"]

//let onlyT = team.filter({ (name:String) -> Bool in
//    return name.hasPrefix("T")
//})

// short way to write

let onlyT = team.filter{ name in
    name.hasPrefix("T")
}

// another shortest way using $0
//let onlyT = team.filter{ $0.hasPrefix("T") }

print(onlyT)
