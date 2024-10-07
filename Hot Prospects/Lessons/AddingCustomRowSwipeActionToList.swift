//
//  AddingCustomRowSwipeActionToList.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 07/10/2024.
//

import SwiftUI

struct AddingCustomRowSwipeActionToList: View {
    var body: some View {
        List {
            ForEach(1..<6) { index in
                Text("Row \(index)")
                    .swipeActions {
                        Button("Delete", systemImage: "minus.circle", role: .destructive) {
                            print("Deleted")
                        }
                        
                        Button("Pin", systemImage: "pin") {
                            print("Pining")
                        }
                        .tint(.green)
                    }
                
                    
                    .swipeActions(edge: .leading) {
                        Button("Archive", systemImage: "archivebox.fill") {
                            print("Archived")
                        }
                        .tint(.orange)
                    }
            }
        }
    }
}

#Preview {
    AddingCustomRowSwipeActionToList()
}
