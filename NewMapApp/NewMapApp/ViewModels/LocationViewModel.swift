//
//  LocationsViewModel.swift
//  NewMapApp
//
//  Created by Sagar Jangra on 22/12/2024.
//


import SwiftUI
import Foundation
import MapKit

@Observable
class LocationViewModel {
    // All loaded locations
    var locations: [Location]
    
    // Current Location
    var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // current region on map
    var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    
    // Show list of locations
    var showLocationList: Bool = false
    
    // Show location detail via sheet
    var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        // get current index
        guard let currentIndex = locations.firstIndex(of: mapLocation) else { return }
        
        // check if next Index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // if next index is not valid start from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // next index is valid
        let nextLocation = locations[nextIndex]  // very unsafe way but we have checked that there is a next index
        showNextLocation(location: nextLocation)
    }
    
    
}
