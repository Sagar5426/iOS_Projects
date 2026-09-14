//
//  ImageLoadingViewModel.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 22/04/2025.
//

import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    let urlString: String
    
    init(url: String) {
        urlString = url
        downloadImage()
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL: \(urlString)")
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {
                print("Image data received: \($0.data.count) bytes")
                return UIImage(data: $0.data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                print("Image decoded successfully: \(returnedImage != nil)")
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
