//
//  Product.swift
//  SwiftUI Practice
//
//  Created by Sagar Jangra on 14/09/2026.
//
import Foundation

// MARK: Products
struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Double        
    let discountPercentage, rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    static var mockProduct: Product {
        .init(
            id: 01,
            title: "iPhone Duo",
            description: "The first folding phone launched by apple in September 2026",
            price: 3_00_000,
            discountPercentage: 1,
            rating: 5,
            stock: 9999,
            brand: "Apple",
            category: "Electronics",
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage, Constants.randomImage, Constants.randomImage]
        )
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String?
    let products: [Product]
    
}

