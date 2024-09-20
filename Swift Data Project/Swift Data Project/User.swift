//
//  User.swift
//  Swift Data Project
//
//  Created by Sagar Jangra on 04/08/2024.
//

import SwiftUI
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
    //relationship will delete jobs to if User is deleted
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

