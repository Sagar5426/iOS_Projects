//
//  EditBookView.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 10/08/2024.
//

import SwiftUI
import SwiftData

struct EditBookView: View {
    @Bindable var expenseItem: ExpenseItem
    @Binding var editMode: Bool
    
    let types = ["🙋‍♂️ Personal","🥗 Food","🎬 Entertainment", "🧥 Clothing","🚘 Traveling","🗂 Others"]
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $expenseItem.name)
                    .listRowBackground(LinearGradient.lightBackground)
                
                Picker("Type", selection: $expenseItem.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .listRowBackground(LinearGradient.lightBackground)
                
                DatePicker("Select date of expense: ", selection: $expenseItem.date, displayedComponents: .date)
                    .listRowBackground(LinearGradient.lightBackground)
                
                TextField("Amount", value: $expenseItem.amount, format: .currency(code:"INR"))
                    .keyboardType(.decimalPad)
                    .listRowBackground(LinearGradient.lightBackground)
            }
            
            .scrollContentBackground(.hidden)
            .background(LinearGradient.darkBackground)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        editMode = false
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .environment(\.colorScheme, .dark)
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        let item = ExpenseItem(name: "", type: "", amount: 0.0, date: Date.now)
        return EditBookView(expenseItem: item, editMode: .constant(true))
            .modelContainer(container)
            .preferredColorScheme(.dark)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
        
}
