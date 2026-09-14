//
//  DownloadingImageView.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 22/04/2025.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var loader:  ImageLoadingViewModel
    
    //
    init(url: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 75, height: 75)
            } else {
                // 👇 This is the fallback when image is nil and not loading
                Text("❌ Failed to load image")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952")
        .frame(width: 75, height: 75)
}
