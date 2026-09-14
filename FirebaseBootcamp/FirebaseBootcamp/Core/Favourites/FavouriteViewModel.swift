//
//  FavouriteViewModel.swift
//  FirebaseBootcamp
//
//  Created by Sagar Jangra on 14/07/2026.
//


import SwiftUI
import Combine
import FirebaseFirestore

@MainActor final class FavouriteViewModel: ObservableObject {
    @Published private(set) var userFavoriteProducts: [UserFavouriteProduct] = []
    private var cancellables = Set<AnyCancellable>()
    
    func addListenerForFavourites() {
        guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {return}
        
//        UserManager.shared.addListenerForAllUserFavouriteProducts(userId: authDataResult.uid) { [weak self] products in
//            self?.userFavoriteProducts = products
//        }
        
        UserManager.shared.addListenerForAllUserFavouriteProducts(userId: authDataResult.uid)
            .sink { completion in
                
            } receiveValue: { [weak self] products in
                self?.userFavoriteProducts = products
            }
            .store(in: &cancellables)

    }
    
    func getFavourites() {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userFavoriteProducts = try await UserManager.shared.getAllUserFavouriteProducts(userId: authDataResult.uid)
            
        }
    }
    
    func removeFromFavourites(favouriteProductId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try await UserManager.shared.removeUserFavouriteProduct(userId: authDataResult.uid, favouriteProductId: favouriteProductId)
            getFavourites()
        }
    }
}