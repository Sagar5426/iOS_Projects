import UIKit

struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining : Int {
        get{
            vacationAllocated - vacationTaken
        }
        set{
            vacationAllocated = vacationTaken + newValue
        }
    }
    
    mutating func vacaRemain() -> Int{
        vacationAllocated = vacationAllocated - vacationTaken
        return vacationAllocated
    }
    
}

var joy = Employee(name: "Joy")
joy.vacationTaken += 4
print(joy.vacationRemaining)

joy.vacationRemaining = 3
print(joy.vacationRemaining)

joy.vacationRemaining += 2
print(joy.vacationRemaining)

print(joy.vacaRemain())




