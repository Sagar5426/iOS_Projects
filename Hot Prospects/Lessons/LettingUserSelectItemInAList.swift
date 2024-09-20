//
//  LettingUserSelectItemInAList.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 20/09/2024.
//


import SwiftUI

// Swipe to right using 2 finger to turn on default multi selection mode
struct LettingUserSelectItemInAList: View {
    let users = ["Sagar","Rohit","Anuj","Priyanshu"]
    @State private var selectedUser = Set<String>()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(users, id: \.self, selection: $selectedUser) { user in
                    Text(user)
                }
                
                if selectedUser.isEmpty == false {
                    Text("You selected \(selectedUser.formatted())")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    LettingUserSelectItemInAList()
}
