import UIKit

enum PasswordError : Error{
    case short, obvious
}
func checkPassword(_ password: String) throws -> String{
    if password.count < 5{
        throw PasswordError.short
    }
    if password == "12345"{
        throw PasswordError.obvious
    }
    
    if password.count < 10{
        return "ok"
    }else{
        return "Good"
    }
}

do{
    let result = try checkPassword("12345")
}catch PasswordError.obvious{
    print("I have same code in my luggage bag")
}
//generic catch for all error
catch{
    print("Error!")
}


