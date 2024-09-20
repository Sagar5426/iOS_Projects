//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 08/08/2024.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
        
    }
}
