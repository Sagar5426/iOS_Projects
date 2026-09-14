//
//  SpotifyPlaylistView.swift
//  SwiftUI Practice
//
//  Created by Sagar Jangra on 14/09/2026.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    var product: Product = .mockProduct
    
    @State private var products: [Product] = []
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? "Orange",
                        imageName: product.thumbnail)
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        username: "Nick",
                        subheadline: product.category,
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: nil,
                            onEllipsisPressed: nil
                        )
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
