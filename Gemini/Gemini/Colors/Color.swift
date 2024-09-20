//
//  Color.swift
//  Gemini
//
//  Created by Sagar Jangra on 20/08/2024.
//

import SwiftUI

extension ShapeStyle where Self == LinearGradient {
    
    static var darkBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.indigo.opacity(0.8),
                Color.purple.opacity(0.6),
                Color.blue.opacity(0.3)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    
}
