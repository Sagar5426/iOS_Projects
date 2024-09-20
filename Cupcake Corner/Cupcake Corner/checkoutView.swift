//
//  checkoutView.swift
//  Cupcake Corner
//
//  Created by Sagar Jangra on 29/07/2024.
//

import SwiftUI

struct checkoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: "https://www.hackingwithswift.com/samples/img/cupcakes@3x.jpg"), scale: 3) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 233)
            
            Text("Your Total cost is \(order.cost, format: .currency(code: "USD"))")
                .font(.title)
            
            Button("Place Order") {
                Task {
                    await placeOrder()
                }
            }
            .padding()
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("Ok") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        //website called https://reqres.in – it lets us send any data we want, and will automatically send it back.
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self,from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcaked is on the way!"
            showingConfirmation = true
        } catch {
            print("checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    checkoutView(order: Order())
}
