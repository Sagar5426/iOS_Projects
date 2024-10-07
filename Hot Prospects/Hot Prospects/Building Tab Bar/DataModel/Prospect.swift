//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 09/10/2024.
//

import SwiftData
import SwiftUI

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}


