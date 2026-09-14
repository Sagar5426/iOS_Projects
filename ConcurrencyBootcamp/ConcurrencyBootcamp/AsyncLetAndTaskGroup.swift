//
//  AsyncLetAndTaskGroup.swift
//  ConcurrencyBootcamp
//
//  Created by Sagar Jangra on 24/12/2025.
//

import SwiftUI
import Combine

class ImageDownloadManager {
    let urlString = "https://picsum.photos/200"
    
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        async let fetchimage1 = fetchImage(urlString: urlString)
        async let fetchimage2 = fetchImage(urlString: urlString)
        async let fetchimage3 = fetchImage(urlString: urlString)
        async let fetchimage4 = fetchImage(urlString: urlString)
        
        let (image1, image2, image3, image4) = await (try fetchimage1, try fetchimage2, try fetchimage3, try fetchimage4)
        return [image1, image2, image3, image4]
    }
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        
        let urlStrings = [
            "https://picsum.photos/300", "https://picsum.photos/300", "https://picsum.photos/300", "https://picsum.photos/300", "https://picsum.photos/300",
        ]
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            
            // Use `try?` to ignore individual failures and keep the task group running
            for urlString in urlStrings {
                group.addTask {
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            
            return images
        }
            
        }
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    }
    
class AsyncLetAndTaskGroupViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    let imageManager = ImageDownloadManager()
    
    func getImages() async {
        if let images = try? await imageManager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
    
}

struct AsyncLetAndTaskGroup: View {
    @StateObject private var vm = AsyncLetAndTaskGroupViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                    }
                }
            }
            .navigationTitle("Task Group")
            .padding()
            .task {
                await vm.getImages()
            }
        }
    }
}

#Preview {
    AsyncLetAndTaskGroup()
}
