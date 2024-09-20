//
//  AddBookView.swift
//  BookWorm
//
//  Created by Sagar Jangra on 01/08/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var showingAddScreen: Bool
    @FocusState private var isInputActive: Bool
    
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var rating = 0
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    private var isEnabled : Bool {
        if title.isEmpty || author.isEmpty {
            return true
        }
        else {
            return false
        }
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                        
                    TextField("Name of author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextField("(Optional)", text: $review, axis: .vertical)
                    
                    RatingView(rating: $rating)
                    
                }
                
                Section {
                    Button("Save") {
                        let book = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        
                        
                        modelContext.insert(book)
                        
                        showingAddScreen = false
                        
                    }
                    .disabled(isEnabled)
                }
                
            }
            .focused($isInputActive)
            .navigationTitle("Add a Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showingAddScreen = false
                    } label: {
                        Image(systemName: "multiply")
                            .foregroundStyle(.gray)
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    AddBookView( showingAddScreen: .constant(true))
}
