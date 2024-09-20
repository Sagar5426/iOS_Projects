import UIKit

// To reverse a number

var number = 123
var reverse = 0

while (number>0){
    var rem = number%10
    reverse = reverse*10+rem
    number /= 10
}

print(reverse)

// for loop

print("myNumberArray")
var myNumberArray = [10,20,30,40,50]

for i in myNumberArray{
    print(i/5)
}

print("Printing 5 table")
var num = 5
for i in 1...10{
    print(num,"x",i,"=",num*i)
}
            

