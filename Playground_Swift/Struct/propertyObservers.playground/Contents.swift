import UIKit

// Property Observer- like didSet - executes whenever changes are made
struct game{
    var score = 0 {
        didSet{
            print("Score is now \(score)")
        }
    }
    
}

var gamerSagar = game()
gamerSagar.score += 30
gamerSagar.score += 8
gamerSagar.score = 99

print("\n")

struct App{
    var contacts = [String]() {
        willSet{
            print("Current Value is: \(contacts)")
            print("New Value is: \(newValue)")
        }
        didSet{
            print("There are now \(contacts.count) contacts")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Rohit")
app.contacts.append("Anuj")
app.contacts.append("Suraj")
