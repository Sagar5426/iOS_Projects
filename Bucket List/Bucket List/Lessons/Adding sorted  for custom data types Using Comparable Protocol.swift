//
//  Adding sorted for custom data types.swift
//  Bucket List
//
//  Created by Sagar Jangra on 22/08/2024.
//

import SwiftUI

struct User: Comparable, Identifiable {
    
    
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName //ascending order
    }
}

struct Adding_sorted_for_custom_data_types: View {
    
    let users = [
        User(firstName: "Sagar", lastName: "Jangra"),
        User(firstName: "Rohit", lastName: "Chaudary"),
        User(firstName: "Anuj", lastName: "Thapa")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

#Preview {
    Adding_sorted_for_custom_data_types()
}
