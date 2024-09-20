//
//  AddView.swift
//  iExpense
//
//  Created by Sagar Jangra on 21/06/2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "🥗 Food"
    @State private var amount = 0.0
    
    var expenses : Expenses
    
    let types = ["🙋‍♂️ Personal","🥗 Food","🎬 Entertainment", "🧥 Clothing","🚘 Traveling" ]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name",text: $name)
                
                Picker("Type",selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("Amount",value: $amount, format: .currency(code: "INR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new Expense")
            
            .toolbar {
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
