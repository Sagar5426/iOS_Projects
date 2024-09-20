//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Sagar Jangra on 30/07/2024.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
