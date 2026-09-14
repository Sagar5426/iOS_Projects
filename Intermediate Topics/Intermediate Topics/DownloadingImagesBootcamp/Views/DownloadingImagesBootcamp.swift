//
//  DownloadingImagesBootcamp.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 30/04/2025.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImageViewModel()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
