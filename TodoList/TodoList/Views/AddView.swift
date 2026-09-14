//
//  AddView.swift
//  TodoList
//
//  Created by Sagar Jangra on 28/11/2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(ListViewModel.self) var listViewModel
    @State var textFieldText: String = ""
    
    //alert
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    saveButtonPressed()
                } label: {
                    Text("SAVE")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }

            }
            .padding(14)
            .alert(Text(alertTitle), isPresented: $showAlert) {
                Button("Ok", role: .cancel) {
                    
                }
            }
            
        }
        .navigationTitle("Add an Item 🖊️")
        
    }
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long! 😱"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    
}



#Preview {
    NavigationStack {
        AddView()
            .environment(ListViewModel())
    }
}
