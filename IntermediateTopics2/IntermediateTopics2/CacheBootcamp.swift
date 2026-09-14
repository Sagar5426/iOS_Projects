//
//  CacheBootcamp.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 27/04/2025.
//

import SwiftUI


class CacheManager {
    static let instance = CacheManager() // Singleton
    private init() {}
    
    // It is computed property that we use modify cache image
    // If reaches the countLimit it removes the previous item and start adding new one this is very useful for developers
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1024 * 1024  // 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to Cache")
    }
    
    func remove(name:String) {
        imageCache.removeObject(forKey: name as NSString)
        print( "Removed from Cache")
    }
    
    func get(name:String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    let imageName: String = "singapore"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
    }
}

struct CacheBootcamp: View {
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Delete From Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

#Preview {
    CacheBootcamp()
}
