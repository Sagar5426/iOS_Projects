import UIKit

struct School{
    static var studentCount = 0
    
    static func add(student: String){
        print("\(student) joined the school")
        studentCount+=1
    }
}

var sagar = School()
School.add(student: "Sagar") // cannot access with var, Only direct access
