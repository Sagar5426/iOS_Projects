//
//  expenseDetailView.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 10/08/2024.
//

import SwiftUI
import SwiftData

struct expenseDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingEditView = false
    @State private var showingDeleteAlert = false
    
    let expense: ExpenseItem
    
    var body: some View {
        ZStack {
            LinearGradient.darkBackground
                .ignoresSafeArea()
            
            ScrollView {
                
                Text("Expense Type: \(expense.type)")
                    .font(.title2)
                    .padding()
                
                Text("Date of expense: \(expense.date, format: .dateTime.day().month().year())")
                
                HStack {
                    Text("Amount:")
                    Text(expense.amount,format: .currency(code: "INR"))
                        .fontWeight(.medium)
                }
                .font(.title3)
                .padding()
                
                
            }
            
            .navigationTitle(expense.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("Delete this book", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteItem)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure?")
            }
            .toolbar {
                Button("Edit Mode", systemImage: "pencil") {
                    showingEditView.toggle()
                }
                Button("Delete this item", systemImage: "trash") {
                    showingDeleteAlert = true
                }
                
            }
            .sheet(isPresented: $showingEditView) {
                EditBookView(expenseItem: expense, editMode: $showingEditView)
            }
            .environment(\.colorScheme, .dark)
        }
    }
    
    func deleteItem() {
        modelContext.delete(expense)
        dismiss()
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        let example = ExpenseItem(name: "Movie", type: "🎬 Entertainment", amount: 23.0, date: Date.now)
        
        return expenseDetailView(expense: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
