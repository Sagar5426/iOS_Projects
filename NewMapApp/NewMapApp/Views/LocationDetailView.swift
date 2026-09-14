//
//  LocationDetailView.swift
//  NewMapApp
//
//  Created by Sagar Jangra on 29/12/2024.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @Environment(LocationViewModel.self) private var vm
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .overlay(alignment: .topLeading) {
            backButton
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        
    }
}

#Preview {
    
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environment(LocationViewModel())
    
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
    
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.body)
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    private var mapLayer : some View {
        
        @State var position = MapCameraPosition.region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        return Map(position: $position) {
            Annotation(location.name, coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(0.8)
                    .shadow(radius: 10)
                    
            }
            
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(10)
                .foregroundStyle(.white)
                .background(
                    Circle()
                        .fill(.thinMaterial)
                )
                .padding()
                .tint(.primary)
        }
    }
}
