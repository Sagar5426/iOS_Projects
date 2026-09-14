//
//  AddDestinationView.swift
//  iTour
//
//  Created by Sagar Jangra on 02/01/2025.
//

import SwiftUI

struct AddDestinationView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var isShowingAddView : Bool
    
    @State private var destinationName : String = ""
    @State private var destinationDetails : String = ""
    @State private var destinationPriority : Int = 2
    @State private var destinationDate: Date = Date.now
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Place name", text: $destinationName)
                TextField("Place details", text: $destinationDetails)
                DatePicker("Select Date", selection: $destinationDate)
                
                Section("Priority") {
                    Picker("Priority", selection: $destinationPriority) {
                        Text("May").tag(1)
                        Text("Maybe").tag(2)
                        Text("Must").tag(3)
                    }
                    .pickerStyle(.segmented)
                }
                
                
            }
            .toolbar {
                Button("Save") {
                    let destination = Destination(name: destinationName, details: destinationDetails, date: destinationDate, priority: destinationPriority)
                    modelContext.insert(destination)
                    isShowingAddView = false
                }
            }
            .navigationTitle("AddView")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

#Preview {
    AddDestinationView(isShowingAddView: .constant(true))
}
