//
//  PracticeHotProspectApp.swift
//  PracticeHotProspect
//
//  Created by Sagar Jangra on 13/10/2024.
//

import SwiftUI

@main
struct PracticeHotProspectApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: Prospect.self)
        }
    }
}
