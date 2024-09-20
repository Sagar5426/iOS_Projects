//
//  hapticWoriking.swift
//  Cupcake Corner
//
//  Created by Sagar Jangra on 28/07/2024.
//

import SwiftUI

struct hapticWorking: View {
    @State private var count = 0
    
    var body: some View {
        Button("Tap Count: \(count)") {
            count += 1
        }
        .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.5), trigger: count)
    }
}

#Preview {
    hapticWorking()
}
