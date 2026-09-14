//
//  LocationView.swift
//  NewMapApp
//
//  Created by Sagar Jangra on 22/12/2024.
//

import SwiftUI
import MapKit
import SwiftData

struct LocationView: View {
    
    @Environment(LocationViewModel.self) private var vm
    let maxWidthForIpad: CGFloat = 700
    
    
    var body: some View {
        // body gets loaded after struct
        // need to declare here bcz using LocationViewModel
        @State var position = MapCameraPosition.region(vm.mapRegion)
        @State var sheetLocation = vm.sheetLocation
        ZStack(alignment: .top) {
            mapLayer
            
            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationPreviewStack
             }
        }
        .sheet(item: $sheetLocation, onDismiss:
                {vm.sheetLocation = nil}) { location in
            LocationDetailView(location: location)
        }
    }
}


#Preview {
    LocationView()
        .environment(LocationViewModel())
}


extension LocationView {
    private var header: some View {
        VStack {
            Button {
                vm.toggleLocationsList()
            } label: {
                Text(vm.mapLocation.name + ", " +  vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            }
            .tint(.primary)
            
            if vm.showLocationList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer : some View {
        
        @State var position = MapCameraPosition.region(vm.mapRegion)
        return Map(position: $position) {
            ForEach(vm.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .animation(.easeInOut(duration: 0.3), value: position)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                    
                }
            }
        }
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                // without this if statement all location in array will stack up on each other in Zstack
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
