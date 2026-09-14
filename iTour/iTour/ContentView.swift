//
//  ContentView.swift
//  iTour
//
//  Created by Sagar Jangra on 02/01/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    
    @State var showAddDestinationSheet: Bool = false
    var body: some View {
        NavigationStack {
            destinationListingView(sort: sortOrder, searchString: searchText)
            .toolbar {
                
                Button("Add", systemImage: "plus") {
                    showAddDestinationSheet = true
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("name")
                            .tag(SortDescriptor(\Destination.name))
                        Text("Priority")
                            .tag(SortDescriptor(\Destination.priority, order: .reverse))
                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                    }
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                EditDestinationView(destination: destination)
            }
            .searchable(text: $searchText, prompt: Text("Search here"))
            .sheet(isPresented: $showAddDestinationSheet) {
                AddDestinationView(isShowingAddView: $showAddDestinationSheet)
            }
            
            
            
            
            .navigationTitle("iTour")
        }
    }
}

#Preview {
    ContentView()
}


