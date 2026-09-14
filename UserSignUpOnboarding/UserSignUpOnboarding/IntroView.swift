//
//  IntroView.swift
//  UserSignUpOnboarding
//
//  Created by Sagar Jangra on 13/11/2024.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            // background
            RadialGradient(
                colors: [Color("first"), Color("second")],
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            // foreground
            ZStack {
                if currentUserSignedIn {
                    ProfileView()
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                } else {
                    OnboardingView()
                        .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                }
            }
            .animation(.easeInOut ,value: currentUserSignedIn)

        }
    }
}

#Preview {
    IntroView()
}
