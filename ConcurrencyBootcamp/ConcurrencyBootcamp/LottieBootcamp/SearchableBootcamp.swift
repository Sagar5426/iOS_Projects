//
//  SearchableBootcamp.swift
//  ConcurrencyBootcamp
//
//  Created by Sagar Jangra on 15/03/2026.
//

import SwiftUI
import Combine

struct Restaurant: Identifiable, Hashable {
    let id: String
    let name: String
    let cuisine: CuisineOption
}

enum CuisineOption: String {
    case italian, american, japanese
}

final class RestaurantManager {
    func getAllRestaurant() async throws -> [Restaurant] {
        return [
            Restaurant(id: "1", name: "Burger Shack", cuisine: .american),
            Restaurant(id: "2", name: "Pasta palace", cuisine: .italian),
            Restaurant(id: "3", name: "Sushie den", cuisine: .japanese),
            Restaurant(id: "4", name: "Local market", cuisine: .american)
        ]
    }
}

@MainActor
final class SearchableViewModel: ObservableObject {
    
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    
    let manager = RestaurantManager()
    
    var filteredRestaurants: [Restaurant] {
        guard !searchText.isEmpty else { return allRestaurants }
        
        return allRestaurants.filter { restaurant in
            restaurant.name.localizedCaseInsensitiveContains(searchText) ||
            restaurant.cuisine.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getAllRestaurant()
        } catch {
            print(error)
        }
    }
}

struct SearchableBootcamp: View {
    
    @StateObject private var vm = SearchableViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vm.filteredRestaurants) { restaurant in
                    restaurantRow(restaurant: restaurant)
                }
            }
            .padding(20)
        }
        .navigationTitle("Restaurants")
        .searchable(
            text: $vm.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search restaurants"
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Sort by Name") {
                        // action
                    }
                    
                    Button("Filter Italian") {
                        // action
                    }
                    
                    Button("Reset Filters") {
                        // action
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .task {
            await vm.loadRestaurants()
        }
    }
    
    private func restaurantRow(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.name)
                .font(.headline)
            Text(restaurant.cuisine.rawValue)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
    }
    
}

#Preview {
    NavigationStack {
        SearchableBootcamp()
    }
}
