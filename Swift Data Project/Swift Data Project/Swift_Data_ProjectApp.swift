//
//  Swift_Data_ProjectApp.swift
//  Swift Data Project
//
//  Created by Sagar Jangra on 04/08/2024.
//

import SwiftUI

@main
struct Swift_Data_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
