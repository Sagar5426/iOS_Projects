import UIKit

enum Weather{
    case sun, wind, rain
}

let forecast = Weather.sun

switch forecast {
case Weather.sun:
    print("Sunny Day")

case .rain:
    print("Pick an umbrella")
    
default: print("A nice day")
}


