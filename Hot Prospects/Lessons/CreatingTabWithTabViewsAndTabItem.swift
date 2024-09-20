//
//  Creating_Tab_WithTabViewsAndTabItem.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 20/09/2024.
//

// tag -> assigns value to a tab using which we can 

import SwiftUI

struct Creating_Tab_WithTabViewsAndTabItem: View {
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

#Preview {
    Creating_Tab_WithTabViewsAndTabItem()
}
