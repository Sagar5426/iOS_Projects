//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 08/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    @State private var filterOut = false
    @State private var sortOrder = [ SortDescriptor(\ExpenseItem.persistentModelID, order: .reverse)]
    
    @State private var unSortedOrder = [ SortDescriptor(\ExpenseItem.persistentModelID, order: .reverse)]
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            // myAmount is unused now but can be used to amount in certain range
            ExpensesView(myAmount: filterOut ? 0: 0, sortOrder: sortOrder)
                .navigationTitle("Expense Tracker")
                .navigationDestination(for: ExpenseItem.self) { item in
                    expenseDetailView(expense: item)
                }
                .toolbar {
                    
                    ToolbarItemGroup(placement: .topBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Add", systemImage: "plus") {
                            showingAddExpense.toggle()
                        }
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by amount")
                                    .tag([
                                        SortDescriptor(\ExpenseItem.amount),
                                        SortDescriptor(\ExpenseItem.name)
                                    ])
                                
                                Text("Sort by name")
                                    .tag([
                                        SortDescriptor(\ExpenseItem.name),
                                        SortDescriptor(\ExpenseItem.amount)
                                    ])
                                
                                Text("Sort by Date")
                                    .tag([
                                        SortDescriptor(\ExpenseItem.date,order: .reverse),
                                        SortDescriptor(\ExpenseItem.name)
                                    ])
                                
                                Text("None")
                                    .tag(unSortedOrder)
                            }
                        }
                        
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddExpenseView(showingAddScreen: $showingAddExpense)
                }
            
        }
        
        .background(LinearGradient.darkBackground)
        .environment(\.colorScheme, .dark)
        
    }
    
    func deleteExpense(at offSets: IndexSet) {
        for offSet in offSets {
            let item = expenses[offSet]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ContentView()
    
}
