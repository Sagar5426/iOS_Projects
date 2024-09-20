//
//  PrimaryButton.swift
//  Trackizer
//
//  Created by Sagar Jangra on 28/08/2024.
//

import SwiftUI

struct PrimaryButton: View {
    @State var title: String = "Title"
    // `onPressed` is an optional closure that takes no parameters and returns nothing (Void).
    // It can be assigned a function to execute on a button press or be nil.

    var onPressed: (() -> ())?
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Image("primary_btn")
                    .resizable()
                    .scaledToFill()
                    .padding(.horizontal, 20)
                    .frame(width: .screenWidth, height: 48)
                
                Text(title)
                
                    .font(.customFont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
            }
        }
        .foregroundStyle(.white)
        .shadow(color: .secondaryC.opacity(0.3), radius: 5, y: 3)
    }
}

#Preview {
    PrimaryButton()
}
