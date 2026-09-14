//
//  ConcurrencyBootcampApp.swift
//  ConcurrencyBootcamp
//
//  Created by Sagar Jangra on 13/12/2025.
//

import SwiftUI

@main
struct ConcurrencyBootcampApp: App {
    var body: some Scene {
        WindowGroup {
            DownloadingImageAsync()
        }
    }
}
