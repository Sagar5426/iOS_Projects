import UIKit

// private - Don't let anything outside struct use this
// filePrivate - Don't let anything outside the current file use this
// public - Let anyone, anywhere use it
// private(set) - Both internal and external methods can read but only internal methods can make changes
struct BankAccount{
    private(set) var funds = 0
    
    mutating func deposit(amount: Int){
        funds+=amount
        print("Amount after deposit: \(funds)")
    }
    
    mutating func withdraw(amount: Int) -> Bool{
        if funds > amount{
            funds -= amount
            print("Amount after withdraw: \(funds)")
            return true
        }else{
            return false
        }
    }
}

var myAccount = BankAccount(funds: 1)
myAccount.withdraw(amount: 0)
myAccount.deposit(amount: 1_00_000)

print(myAccount.funds) // can be seen outside but can't manipulate
