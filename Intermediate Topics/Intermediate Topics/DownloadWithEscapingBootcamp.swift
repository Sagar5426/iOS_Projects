//
//  DownloadWithEscapingBootcamp.swift
//  prac_GeoReader
//
//  Created by Sagar Jangra on 01/04/2025.
//

import SwiftUI

// We create this model after seeing the data we receive in jsonObject
struct postModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [postModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        // This url API is fetched from https://jsonplaceholder.typicode.com
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([postModel].self, from: data) else {return}
                
                // Update the UI on the main thread
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned")
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        // this dataTask automatically runs on background thread by default so we will update(or append new data) in main thread we cant do it on background thread
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Ensure data is received successfully and the response status code is in the success range (200-299)
            guard let data = data,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
            else {
                print("No Data")
                completionHandler(nil)
                return
            }
            completionHandler(data)
            
        }.resume() // Start the network request
    }
}

struct DownloadWithEscapingBootcamp: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}




