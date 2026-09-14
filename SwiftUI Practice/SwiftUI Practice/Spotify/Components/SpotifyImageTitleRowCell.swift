//
//  SpotifyImageTitleRowCell.swift
//  SwiftUI Practice
//
//  Created by Sagar Jangra on 14/09/2026.
//

import SwiftUI

struct SpotifyImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "Some Item Name"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
                .background(.spotifyWhite)
                .cornerRadius(10)
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGrey)
                .lineLimit(2, reservesSpace: true)
                .padding(4)
        }
        .frame(maxWidth: imageSize)
    }
}

#Preview {
    SpotifyImageTitleRowCell()
}
