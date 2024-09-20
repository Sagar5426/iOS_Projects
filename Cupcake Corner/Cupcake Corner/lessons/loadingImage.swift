//
//  loadingImage.swift
//  Cupcake Corner
//
//  Created by Sagar Jangra on 27/07/2024.
//

import SwiftUI

struct loadingImage: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://www.hackingwithswift.com/samples/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading an image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    loadingImage()
}
