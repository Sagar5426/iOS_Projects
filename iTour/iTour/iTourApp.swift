//
//  iTourApp.swift
//  iTour
//
//  Created by Sagar Jangra on 02/01/2025.
//

import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
