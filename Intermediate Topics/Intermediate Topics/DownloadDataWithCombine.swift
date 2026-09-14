//
//  DownloadDataWithCombine.swift
//  prac_GeoReader
//
//  Created by Sagar Jangra on 11/04/2025.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadDataWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    
    // A set of cancellables to store active subscriptions, ensuring they don't get deallocated prematurely.
    
    // easy explanation: A "safe place" to store our magic mailboxes (subscriptions).
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        
        // Combine Discussion
        /*
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. recieve the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!!
        // 7. cancellable at any time!!
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. recieve on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        */
        
        // It creates a publisher that fetches data from the given URL once when subscribed
        // By default this .subscribe(means data downloaded) on background thread but we are explicitely mentioning it because in some cases it may not download data on background thread
        // and we update the data on main thread i.e we .recieve on main thread
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables) // 🏠 Keep our "mailbox" safe so it doesn’t disappear!
        /*
                🔴 Without `.store(in: &cancellables)`, the mailbox would disappear immediately, and we wouldn’t receive any posts! 😱
                🔴 But this doesn’t mean we get new posts automatically in the future. If we want new posts later, we have to call `getPosts()` again.
                */
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadDataWithCombine: View {
    @StateObject var vm = DownloadDataWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                Text(post.title)
                    .font(.title.bold())
                    .foregroundStyle(.black)
                    
                Text(post.body)
                    .font(.body)
                    .foregroundStyle(.gray)
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    DownloadDataWithCombine()
}
