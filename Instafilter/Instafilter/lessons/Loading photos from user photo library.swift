//
//  Loading photos from user photo library.swift
//  Instafilter
//
//  Created by Sagar Jangra on 16/08/2024.
//


import PhotosUI
import SwiftUI

//For Loading single Image
struct Loading_photos_from_user_photo_library: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            
            selectedImage?
                .resizable()
                .scaledToFit()
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
}


#Preview {
    Loading_photos_from_user_photo_library()
}
