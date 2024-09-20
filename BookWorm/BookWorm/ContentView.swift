//
//  ContentView.swift
//  BookWorm
//
//  Created by Sagar Jangra on 30/07/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                        .foregroundStyle(book.rating < 2 ? .red: .primary)
                                    
                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                
                                HStack(alignment: .bottom) {
                                    Text(Date.now, format: .dateTime.day().month().year())
                                        .foregroundStyle(.tertiary)
                                        .font(.caption)
                                }
                            }
                            
                            
                                
                        
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .navigationDestination(for: Book.self) { book in
                    DetailView(book: book)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView(showingAddScreen: $showingAddScreen)
                }
        }
    }
    
    func deleteBooks(at offSets: IndexSet) {
        for offSet in offSets {
            let book = books[offSet]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}





