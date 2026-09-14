//
//  FavouriteView.swift
//  FirebaseBootcamp
//
//  Created by Sagar Jangra on 13/07/2026.
//

import SwiftUI


struct FavouriteView: View {
    @StateObject private var vm = FavouriteViewModel()
    
    var body: some View {
        List {
            ForEach(vm.userFavoriteProducts, id: \.id.self) { item in
                ProductCellViewBuilder(productId: String(item.productId))
                    .contextMenu {
                        Button("Remove from favourites") {
                            vm.removeFromFavourites(favouriteProductId: item.id)
                        }
                    }
            }
        }
        .navigationTitle("Favourites")
        .onFirstAppear {
            vm.addListenerForFavourites()
        }
    }
}

#Preview {
    NavigationStack {
        FavouriteView()
    }
}

