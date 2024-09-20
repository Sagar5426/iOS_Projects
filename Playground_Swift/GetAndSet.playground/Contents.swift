import UIKit

struct Employee {
    let name: String
    var vacationAllowed = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            return vacationAllowed - vacationTaken
        }
        set {
            vacationAllowed = vacationTaken + newValue
        }
    }
}

var sagar = Employee(name: "Sagar")
print("Initial vacation remaining for \(sagar.name): \(sagar.vacationRemaining)")

// Let's take some vacation
sagar.vacationTaken = 5
print("Vacation taken for \(sagar.name): \(sagar.vacationTaken)")

// Now let's see the updated remaining vacation
print("Updated vacation remaining for \(sagar.name): \(sagar.vacationRemaining)")

// Now let's set a new value for vacationRemaining
sagar.vacationRemaining = 8
print("Updated vacation remaining for \(sagar.name) after setting vacationRemaining: \(sagar.vacationRemaining)")
