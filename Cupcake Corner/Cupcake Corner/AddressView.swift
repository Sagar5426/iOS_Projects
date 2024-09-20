//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Sagar Jangra on 28/07/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Postal Zip Code", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    checkoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    AddressView(order: Order())
}
#Preview {
    ContentView()
}
