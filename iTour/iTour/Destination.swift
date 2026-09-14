//
//  Destination.swift
//  iTour
//
//  Created by Sagar Jangra on 02/01/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Destination: Identifiable {
    var id  = UUID().uuidString
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights = [Sight]()
    
    init(id: String = UUID().uuidString, name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.id = id
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
