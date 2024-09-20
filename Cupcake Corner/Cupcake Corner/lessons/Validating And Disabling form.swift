//
//  Validating And Disabling form.swift
//  Cupcake Corner
//
//  Created by Sagar Jangra on 27/07/2024.
//

import SwiftUI

struct Validating_And_Disabling_form: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating Account...")
                }
                .disabled(disableForm)
            }
        }
    }
}

#Preview {
    Validating_And_Disabling_form()
}
