//
//  destinationListingView.swift
//  iTour
//
//  Created by Sagar Jangra on 02/01/2025.
//

import SwiftData
import SwiftUI

struct destinationListingView: View {
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                            .font(.subheadline)
                    }
                }
            }
            .onDelete(perform: deleteDestination)
        }
    }
    
    
}

#Preview {
    destinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}

extension destinationListingView {
    // Additional init to take query as argument
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty { // return all
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        } , sort: [sort])
    }
    
    func deleteDestination(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}
