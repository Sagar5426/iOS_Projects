//
//  ListView.swift
//  TodoList
//
//  Created by Sagar Jangra on 28/11/2024.
//

import SwiftUI

struct ListView: View {
    @Environment(ListViewModel.self) private var listViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                    
                }
                .listStyle(PlainListStyle())
            }
        }
        
        .navigationTitle("Todo List 📝")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Add", destination: AddView())
            }
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        ListView()
            .environment(ListViewModel())
    }
}


