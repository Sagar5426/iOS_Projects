//
//  ProductsView.swift
//  FirebaseBootcamp
//
//  Created by Sagar Jangra on 07/07/2026.
//

import SwiftUI


struct ProductsView: View {
    @StateObject private var vm = ProductsViewModel()
    var body: some View {
        List {
            
            ForEach(vm.products) { product in
                ProductCellView(product: product)
                    .contextMenu {
                        Button("Add to favourites") {
                            vm.addUserFavourite(productId: product.id)
                        }
                    }
                
                if product == vm.products.last {
                    ProgressView()
                        .onAppear {
                            vm.getProducts()
                        }
                }
            }
        }
        .navigationTitle("Products")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Menu("Filter: \(vm.selectedFilter?.rawValue ?? "None")") {
                    ForEach(ProductsViewModel.FilterOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await vm.filterSelected(option: option)
                            }
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Category: \(vm.selectedCategory?.rawValue ?? "None")") {
                    ForEach(ProductsViewModel.CategoryOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await vm.categorySelected(option: option)
                            }
                        }
                    }
                }
            }
        })
        .task {
            vm.getProducts()
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
