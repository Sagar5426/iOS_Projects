//
//  ListRowView.swift
//  TodoList
//
//  Created by Sagar Jangra on 28/11/2024.
//

import SwiftUI

struct ListRowView: View {
    
    
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        
        .font(.title2)
        .padding(.vertical, 6)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ListRowView(item: ItemModel(title: "First title", isCompleted: false))
    ListRowView(item: ItemModel(title: "Second title", isCompleted: true))
    
        
    
}


