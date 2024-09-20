//
//  ContentView.swift
//  LockSwiftUIView
//
//  Created by Sagar Jangra on 30/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LockView(lockType: .both, lockPin: "3214", isEnabled: true, lockWhenAppGoesBackground: true) {
            VStack {
                Text("Hello")
            }
        }
    }
}

#Preview {
    ContentView()
}
