//
//  Showing multiple options using confirmationDialog.swift
//  Instafilter
//
//  Created by Sagar Jangra on 15/08/2024.
//

import SwiftUI

struct Showing_multiple_options_using_confirmationDialog: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Button("Click me") {
            showingConfirmation.toggle()
        }
        .foregroundStyle(.primary)
        .font(.title3)
        
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        .confirmationDialog("Change background", isPresented: $showingConfirmation) {
            Button("red") { backgroundColor = .red}
            Button("green") { backgroundColor = .green}
            Button("blue") { backgroundColor = .blue}
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a new color.")
        }
    }
}

#Preview {
    Showing_multiple_options_using_confirmationDialog()
}
