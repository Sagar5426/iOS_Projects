//
//  ContentView.swift
//  prac_GeoReader
//
//  Created by Sagar Jangra on 26/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<20, id: \.self) { index in
                    GeometryReader { geometry in
                        Text("Item \(index)")
                            .frame(width: 300, height: 100)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(10)
                            .rotationEffect(.degrees(Double(geometry.frame(in: .global).minY) / 10))
                            .scaleEffect(1 - (geometry.frame(in: .global).minY / 500))
                    }
                    .frame(height: 100) // Ensures correct height allocation
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
