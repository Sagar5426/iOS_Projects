//
//  EditBookView.swift
//  BookWorm
//
//  Created by Sagar Jangra on 04/08/2024.
//

import SwiftUI
import SwiftData

struct EditBookView: View {
    @Bindable var book: Book
    @Binding var showingEditView: Bool
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $book.title)
                    TextField("Name of author", text: $book.author)
                    
                    Picker("Genre", selection: $book.genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextField("(optional)", text: $book.review, axis: .vertical)
                    RatingView(rating: $book.rating)
                }
                
            }
            .navigationTitle("Editing Mode")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        showingEditView = false
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let book = Book(title: "", author: "", genre: "", review: "", rating: 2)
        return EditBookView(book : book, showingEditView: .constant(true))
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
