//
//  AsyncPublisher.swift
//  ConcurrencyBootcamp
//
//  Created by Sagar Jangra on 18/01/2026.
//

import SwiftUI
import Combine


// Func inside actor are by Default Async but just Explicitly written for clarity
class AsyncPublisherDataManager {
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Orange")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Watermelon")
    }
    
}

class AsyncPublisherViewModel: ObservableObject {
    @Published var fruits: [String] = []
    let manager = AsyncPublisherDataManager()
    var cancellabes = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        // Important note that these await function waits for the data to come for forever if no data comes we hit a bug the the code forward to this lines never executes
        Task {
            for await value in manager.$myData.values {
                await MainActor.run {
                    self.fruits = value
                }
            }
        }
        
        
//        // Old way to do it : Explain why new approach is better
//        manager.$myData
//            .receive(on: DispatchQueue.main, options: nil)
//            .sink { [weak self] dataArray in
//                self?.fruits = dataArray
//            }
//            .store(in: &cancellabes)
    }
    
    
    func start() async {
        await manager.addData()
    }
    
    
}

struct AsyncPublisher: View {
    @StateObject var vm = AsyncPublisherViewModel()
    
    var body: some View {
        List(vm.fruits, id: \.self) { fruit in
            Text(fruit)
        }
        .task {
            await vm.start()
        }
    }
}

#Preview {
    AsyncPublisher()
}




