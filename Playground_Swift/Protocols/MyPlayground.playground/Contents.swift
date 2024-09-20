import UIKit

protocol vehicle{
    func estimateTime(for distance: Int) -> Int
    func travel(distance:Int)
    var model:String  { get  }
    var currentPassengers: Int{get set}
}

protocol mileage{
    func mileage(distance:Int) -> Int
}

class Drive{
    func driving() -> Void{
        
    }
}

struct Car : vehicle, mileage{
    var currentPassengers: Int
    
    var model: String
    
    func mileage(distance: Int) -> Int {
        return 0
    }
    
    func estimateTime(for distance: Int) -> Int {
        return distance/60
    }
    
    func travel(distance: Int) {
        //void
    }
    
    
}

class bmw {
    
}

class volvo : bmw{
    
}

class tataMotor : volvo{
    
}


