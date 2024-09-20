//
//  ContentView.swift
//  iExpense
//
//  Created by Sagar Jangra on 17/06/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    // Conforming to the Identifiable protocol ensures each instance has a unique id, making the 'id' property mandatory.
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}


@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try?  JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
    
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var totalExpense = 0
    
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "INR"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense",systemImage:"plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented : $showingAddExpense) {
                AddView(expenses : expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
}



#Preview {
    ContentView()
}


