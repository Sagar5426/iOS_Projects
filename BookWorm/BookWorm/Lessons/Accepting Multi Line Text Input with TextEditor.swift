//
//  Accepting Multi Line Text Input with TextEditor.swift
//  BookWorm
//
//  Created by Sagar Jangra on 30/07/2024.
//

// Two ways to use multiline text

import SwiftUI

struct Accepting_Multi_Line_Text_Input_with_TextEditor: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        Form {
            Section {
                TextEditor(text: $notes)
                    .navigationTitle("Notes")
                    .padding()
            }
            Section{
                TextField("Enter your text", text: $notes, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .navigationTitle("Notes")
                    .padding()
            }
        }
    }
}

#Preview {
    Accepting_Multi_Line_Text_Input_with_TextEditor()
}
