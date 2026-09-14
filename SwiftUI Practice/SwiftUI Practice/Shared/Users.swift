//
//  Users.swift
//  SwiftUI Practice
//
//  Created by Sagar Jangra on 14/09/2026.
//

import Foundation

// MARK: Users
struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Double
    let weight: Double
}
