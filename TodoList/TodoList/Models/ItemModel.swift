//
//  itemModel.swift
//  TodoList
//
//  Created by Sagar Jangra on 28/11/2024.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    // Now we have two init
    // 1. one with id parameter: Will be used to update code
    // 2. another without id parameter: Will be used to create new Model.(automatically generate uuid)
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    // here 'let' is used to define variable that is why we define new ItemModel and then fill all these copied and altered values in the correct index
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}




