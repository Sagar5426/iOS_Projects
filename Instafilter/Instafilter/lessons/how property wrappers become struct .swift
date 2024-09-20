//
//  property wrappers become struct .swift
//  Instafilter
//
//  Created by Sagar Jangra on 15/08/2024.
//

import SwiftUI

struct how_property_wrappers_become_struct_: View {
    
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    var body: some View {
        Text("Hello, World!")
            .blur(radius: blurAmount)
        
        Slider(value: $blurAmount, in: 0...20)
            .padding(.horizontal)
        
        Button("Random blur") {
            blurAmount = Double.random(in: 0...20)
        }
    }
}

#Preview {
    how_property_wrappers_become_struct_()
}
