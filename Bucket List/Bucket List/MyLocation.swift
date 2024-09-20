//
//  Location.swift
//  Bucket List
//
//  Created by Sagar Jangra on 24/08/2024.
//

import MapKit
import SwiftUI

struct MyLocation: Codable, Equatable, Identifiable {
    
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = MyLocation(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)
    
    #if DEBUB
    static let example = MyLocation(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40k lightbulbs.", latitude: 51.501, longitude: -0.141)
    #endif
    
    static func ==(lhs: MyLocation, rhs: MyLocation) -> Bool {
        lhs.id == rhs.id
    }
        
}


