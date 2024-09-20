//
//  ContentView.swift
//  Custom Swipe Action
//
//  Created by Sagar Jangra on 29/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Messages")
        }
    }
}

#Preview {
    ContentView()
}
