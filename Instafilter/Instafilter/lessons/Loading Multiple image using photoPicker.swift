//
//  Loading Multiple image using photoPicker.swift
//  Instafilter
//
//  Created by Sagar Jangra on 16/08/2024.
//

import SwiftUI
import PhotosUI

struct Loading_Multiple_image_using_photoPicker: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [ .images, .not(.screenshots) ]) ) {
                Label("Select a picture", systemImage: "photo")
            }
            
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .frame(width: 400, height: 400)
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    Loading_Multiple_image_using_photoPicker()
}
