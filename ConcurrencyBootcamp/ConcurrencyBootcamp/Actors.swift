//
//  Actors.swift
//  ConcurrencyBootcamp
//
//  Created by Sagar Jangra on 30/12/2025.
//

import SwiftUI
import Combine

// Old way to do when actors dont exist using Queues(hard and messy to implement)
class myDataManager {
    static let instance = myDataManager()
    private init() {}
    
    private var data: [String] = []
    private let queueLock = DispatchQueue(label: "com.MyApp.dataManager")
    
    func getRandomData(completionHandler: @escaping (_ title: String?) -> ()) {
        queueLock.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
    }
}

// Best way to handle Race conditions
// Every func and variable is async even if we dont mark it async
actor myActorDataManager {
    static let instance = myActorDataManager()
    private init() {}
    
    private var data: [String] = []
    nonisolated let randomText = "asdasd3223*^%%"
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    // All variable and func are isolated by default in Actors. To access them without await and Async environment we can mark it as nonisolated
    // Means everything in actor is async except nonisolated properties
    nonisolated func getSavedData() -> String {
        return "New Data"
    }
    
}


struct homeView: View {
    let manager = myActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 1, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.6).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
        }
    }
}

struct searchView: View {
    let manager = myActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 1, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
        }
    }
}



struct Actors: View {
    var body: some View {
        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                homeView()
            }
            
            Tab("Browse", systemImage: "magnifyingglass") {
                searchView()
            }
            
                
        }
    }
}

#Preview {
    Actors()
}
