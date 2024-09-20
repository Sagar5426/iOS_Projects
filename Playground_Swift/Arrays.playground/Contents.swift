import UIKit

// Arrays

var myFavouriteMovies = ["Martian","Tumse Na Ho Payega","3 Idiots",5,true] as [Any]

myFavouriteMovies[0]
myFavouriteMovies[1]
myFavouriteMovies[2]
myFavouriteMovies[3]
myFavouriteMovies[4]

print(myFavouriteMovies)

var myStringArray = ["Test1","Test2","Test3"]
myStringArray[myStringArray.count-1]
myStringArray.last

print(myStringArray)

// Set
// unordered collection // random output
var mySet:Set=[1,2,3,4,5,4,3,1,2]
mySet.first
print(mySet)

var myAlphabetSet: Set = ["a","b","c","a"]
myAlphabetSet
var naturalNumberSet: Set = [1,2,3,4,5]

var set1:Set=[1,2,3]
var set2:Set=[4,5,6]

var set3 = set1.union(set2)



