//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 08/08/2024.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.modelContext) var modelContext
    
    @Binding var showingAddScreen: Bool
    
    @State private var name = ""
    @State private var type = "🥗 Food"
    @State private var amount = Decimal(0.0)
    @State private var date = Date.now
    
    private var isEnabled: Bool {
        if name.isEmpty || amount < 1 {
            return true
        } else {
            return false
        }
    }
    
    let types = ["🙋‍♂️ Personal","🥗 Food","🎬 Entertainment", "🧥 Clothing","🚘 Traveling", "🗂 Others"]
    
    var body: some View {
        NavigationStack {
            List {
                
                TextField("Expense name", text: $name)
                    .listRowBackground(LinearGradient.lightBackground)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .listRowBackground(LinearGradient.lightBackground)
                
                DatePicker("Date of expense: ", selection: $date, displayedComponents: .date)
                
                    .listRowBackground(LinearGradient.lightBackground)
                
                TextField("Amount", value: $amount, format: .currency(code:"INR"))
                    .keyboardType(.decimalPad)
                    .listRowBackground(LinearGradient.lightBackground)
            }
            .listRowBackground(LinearGradient.lightBackground)
            
            
            .navigationTitle("Add new expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, date: date)
                    // code to save data
                    modelContext.insert(item)
                    showingAddScreen = false
                }
                .disabled(isEnabled)
            }
            .scrollContentBackground(.hidden)
            .background(LinearGradient.darkBackground)
            
        }
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    AddExpenseView(showingAddScreen: .constant(true))
}
