//
//  Integrating swiftui with MapKit.swift
//  Bucket List
//
//  Created by Sagar Jangra on 23/08/2024.
//

import SwiftUI
import MapKit


struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
struct Integrating_swiftui_with_MapKit: View {
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        VStack {
            Map {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: location.coordinate)
                }
            }
            
        }
        
        
    }
}

#Preview {
    Integrating_swiftui_with_MapKit()
}
