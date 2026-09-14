//
//  MyCollegePalApp.swift
//  MyCollegePal
//
//  Created by Sagar Jangra on 14/04/2025.
//

import SwiftUI

@main
struct MyCollegePalApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: Subject.self)
    }
}
