//
//  DownloadingImagesRow.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 22/04/2025.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 002, title: "Image", url: "url", thumbnailUrl: "thumbnail Url"))
        .padding()
        
}
