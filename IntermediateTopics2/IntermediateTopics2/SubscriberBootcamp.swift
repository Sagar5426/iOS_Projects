//
//  SubscriberBootcamp.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 13/04/2025.
//

import SwiftUI
import Combine

class SubscriberBootcampViewModel: ObservableObject {
    @Published var count: Int = 0
    var cancellables = Set<AnyCancellable>()
   
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubsriber()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
        // instead self? we can check that self is valid using guard statement
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
            }
            .store(in: &cancellables)
            
    }
    
    // this $textFieldText acts as a publisher
    func addTextFieldSubscriber() {
        $textFieldText
        // debounce: other example that it can be used in searches to cause delay in searching to prevent extra memory usage because func is running for every word then
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                } else {
                    return false
                }
            }
            // this transform string value to bool and we receive that value in sink operation
            .sink { [weak self] isValid in
                self?.textIsValid = isValid
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubsriber() {
        $textIsValid
            .combineLatest($count)  // combines to value and used them as publisher
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
        
    }
}

struct SubscriberBootcamp: View {
    @StateObject private var vm = SubscriberBootcampViewModel()
    
    var body: some View {
        Text("\(vm.count)")
            .font(.largeTitle.bold())
        
        Text("\(vm.textIsValid)")
            .font(.title)
        
        TextField("Type Something here...", text: $vm.textFieldText)
            .padding(.leading)
            .frame(height: 55)
            .font(.headline)
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            .padding()
            .overlay(alignment: .trailing) {
                ZStack {
                    Image(systemName: "xmark")
                        .foregroundStyle(.red)
                        .opacity(
                            vm.textFieldText.count < 1 ? 0 : vm.textIsValid ? 0 : 1
                        )
                    
                    Image(systemName: "checkmark")
                        .foregroundStyle(.green)
                        .opacity(vm.textIsValid ? 1 : 0)
                }
                .font(.title)
                .padding(.trailing, 20)
            }
        
        Button {
            
        } label: {
            Text("Submit".uppercased())
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                .opacity(vm.showButton ? 1 : 0.5)
        }
        .disabled(!vm.showButton)
        
            
    }
}

#Preview {
    SubscriberBootcamp()
}
