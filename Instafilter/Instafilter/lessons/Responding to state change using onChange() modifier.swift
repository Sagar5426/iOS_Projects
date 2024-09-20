//
//  Responding to state change using onChange() modifire.swift
//  Instafilter
//
//  Created by Sagar Jangra on 15/08/2024.
//

import SwiftUI

struct Responding_to_state_change_using_onChange___modifier: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    var body: some View {
        Text("Hello, World!")
            .blur(radius: blurAmount)
        
        // didSet do work on Slider like views
        Slider(value: $blurAmount, in: 0...20)
            .onChange(of: blurAmount) { oldvalue, newValue in
                print("Value Changes to \(newValue) from \(oldvalue)")
            }
            .padding(.horizontal)
        
        Button("Random blur") {
            blurAmount = Double.random(in: 0...20)
        }
    }
}

#Preview {
    Responding_to_state_change_using_onChange___modifier()
}
