//
//  EditDestinationView.swift
//  iTour
//
//  Created by Sagar Jangra on 02/01/2025.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var destination: Destination
    @State var newSightName = ""
    
    var body: some View {
        Form {
            TextField("Place name", text: $destination.name)
            TextField("Place details", text: $destination.details)
            DatePicker("Select Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("May").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSight)
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    Button("Add", action: addSight)
                }
            }
            
            
        }
        
    }
}



#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example", details: "Example Details")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create preview: \(error)")
    }
    
}

extension EditDestinationView {
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteSight(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destination.sights[index]
            modelContext.delete(destination)
        }
    }
}
