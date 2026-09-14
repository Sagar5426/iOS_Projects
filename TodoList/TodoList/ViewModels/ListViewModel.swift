//
//  ListViewModel.swift
//  TodoList
//
//  Created by Sagar Jangra on 28/11/2024.
//

import Foundation

@Observable
class ListViewModel {
    let itemsKey: String = "items_list" //made for userDefault storage
    
    var items: [ItemModel] = [ ] {
        didSet {
            saveItems()
        }
    }
    
    init() {
        getItems()
    }
    
    func getItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey) {
            if let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) {
                self.items = savedItems
            }
        }
    }
    
    func deleteItem (indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}
