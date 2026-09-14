//
//  NewMapAppApp.swift
//  NewMapApp
//
//  Created by Sagar Jangra on 22/12/2024.
//

import SwiftUI

@main
struct NewMapAppApp: App {
    @State private var vm = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environment(vm)
        }
    }
}
