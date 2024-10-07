//
//  Hot_ProspectsApp.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 20/09/2024.
//

import SwiftData
import SwiftUI

@main
struct Hot_ProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Prospect.self)
    }
}
