import UIKit

struct Player{
    var name: String
    var number: Int
    var HighScore: Int
    
    // can make as many as we want - need to cover all properties
    // 2 out of 3 properties in init
    init(name: String, number: Int) {
        self.name = name
        self.number = number
        self.HighScore = 0
    }
    
    // 1 out of 3 properties in init
    init(name: String) {
        self.name = name
        self.number = Int.random(in: 1...99)
        self.HighScore = 0
    }
}

let player1 = Player(name: "Harry")
print(player1.name, player1.number)

let player2 = Player(name: "Hermione", number: 2)
print(player2.name, player2.number,player2.HighScore)
