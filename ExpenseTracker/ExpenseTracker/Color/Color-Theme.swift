//
//  Color-Theme.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 13/08/2024.
//

import SwiftUI

extension ShapeStyle where Self == LinearGradient {
    
    static var darkBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.20, green: 0.17, blue: 0.14), // Very dark brown
                Color(red: 0.30, green: 0.25, blue: 0.21), // Dark brownish color
                Color(red: 0.40, green: 0.34, blue: 0.29)  // Dark beige
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static var lightBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.42, green: 0.35, blue: 0.29), // Slightly lighter dark beige
                Color(red: 0.35, green: 0.29, blue: 0.23), // Dark beige
                Color(red: 0.29, green: 0.24, blue: 0.19)  // Darker beige
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
