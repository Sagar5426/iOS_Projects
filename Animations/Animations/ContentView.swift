//
//  ContentView.swift
//  Animations
//
//  Created by Sagar Jangra on 08/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var rotateAmount = 1.0
    @State private var overlayAmount = 1.0
    
    var body: some View {
        VStack {
            Stepper("Scale Amount: \(animationAmount.formatted())",value: $animationAmount,in: 1...20)
            
            Button("Rotate me"){
                withAnimation(.spring(duration: 1, bounce: 0.5)){
                    rotateAmount += 360
                }
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(
                .degrees(rotateAmount),axis: (x: 1, y: -1, z: 0)
            )
            .padding(.top,50)
            
            Spacer()
            
            Button("PK Remote"){
                
            }
            .padding(45)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(overlayAmount)
                    .opacity(2 - overlayAmount)
                    .animation(.easeOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                               value: overlayAmount
                    )
            )
            .onAppear{
                overlayAmount = 2
            }
            
            
            Spacer()
            
            Button("Tap me"){
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
            .animation(.default, value: animationAmount)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
