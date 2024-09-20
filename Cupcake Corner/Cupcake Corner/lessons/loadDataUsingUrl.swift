//
//  loadDataUsingUrl.swift
//  Cupcake Corner
//
//  Created by Sagar Jangra on 27/07/2024.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct loadDataUsingUrl: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=honey+singh&entity=song")
        else {
            print("Invalid Url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // Tuple return type (data, _)
            // URLSession's data(from:) method returns both data and metadata.
            // We use an underscore (_) to ignore the metadata.
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
            
        } catch {
            print("Invalid data")
        }
        
    }
}

#Preview {
    loadDataUsingUrl()
}
