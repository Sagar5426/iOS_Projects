//
//  WelcomeView.swift
//  Trackizer
//
//  Created by Sagar Jangra on 28/08/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("welcome_screen")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack {
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .widthPer(per: 0.5))
                    .padding(.top, .topInsets + 8)
                
                Spacer()
                Text("Flibberty jank spoodle glorf wibbly snazzle\n zork pingle frozzle cronk dizzle blart woofle.")
                    .multilineTextAlignment(.center)
                    .font(.customFont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                PrimaryButton(title: "Get Started", onPressed: {
                    
                })
                .padding(.bottom, .bottomInsets)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WelcomeView()
}
