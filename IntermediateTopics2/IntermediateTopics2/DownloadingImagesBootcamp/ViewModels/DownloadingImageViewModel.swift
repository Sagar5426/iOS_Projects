//
//  DownloadingImageViewModel.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 22/04/2025.
//

import Foundation
import Combine

class DownloadingImageViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] (returnedPhotoModels) in
            self?.dataArray = returnedPhotoModels
        }
            .store(in: &cancellables)
    }
    
}
