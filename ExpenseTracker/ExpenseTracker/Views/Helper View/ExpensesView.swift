//
//  ExpensesView.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 12/08/2024.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Query var expenses: [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            ForEach(expenses) { item in
                NavigationLink(value: item) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "INR"))
                    }
                }
                .listRowBackground(LinearGradient.lightBackground)
            }
            .onDelete(perform: deleteExpense)
        }
        .scrollContentBackground(.hidden)
        .background(LinearGradient.darkBackground)
        .environment(\.colorScheme, .dark)


    }
    
    func deleteExpense(at offSets: IndexSet) {
        for offSet in offSets {
            let item = expenses[offSet]
            modelContext.delete(item)
        }
    }
    
    init(myAmount: Decimal, sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { item in
            item.amount >= myAmount
        }, sort: sortOrder)
        
    }
}

#Preview {
    ExpensesView(myAmount: 24.0, sortOrder: [SortDescriptor(\ExpenseItem.amount)])
        .modelContainer(for: ExpenseItem.self)
}
