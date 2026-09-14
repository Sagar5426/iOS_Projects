//
//  TodoListApp.swift
//  TodoList
//
//  Created by Sagar Jangra on 28/11/2024.
//

import SwiftUI

@main
struct TodoListApp: App {
    @State var listViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack() {
                ListView()
            }
            
            .environment(listViewModel)
            
        }
    }
}
