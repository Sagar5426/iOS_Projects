//
//  ExpenseItem.swift
//  ExpenseTracker
//
//  Created by Sagar Jangra on 08/08/2024.
//

import SwiftData
import SwiftUI

let types = ["🙋‍♂️ Personal","🥗 Food","🎬 Entertainment", "🧥 Clothing","🚘 Traveling" ]

@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var amount: Decimal
    var date : Date
    
    init(id: UUID = UUID(), name: String, type: String, amount: Decimal, date: Date) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.date = date
    }
}
