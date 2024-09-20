//
//  ContentView.swift
//  Gemini
//
//  Created by Sagar Jangra on 18/08/2024.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKEY.default)
    
    @State private var userPrompt = ""
    @State private var response: LocalizedStringKey = "How can I help you today?"
    @State private var isLoading = false
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Welcome to Gemini AI")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.indigo)
                        .padding(.top, 40)
                    
                    ZStack {
                        ScrollView {
                            Text(response)
                                .font(.title2)
                        }
                        
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(.indigo)
                                .scaleEffect(2.5)
                        }
                    }
                    HStack {
                        TextField("Ask me anything...", text: $userPrompt, axis: .vertical)
                            .lineLimit(5)
                            .padding()
                            .background(.indigo.opacity(0.2), in: Capsule())
                            .autocorrectionDisabled(true)
                            .focused($isFocused)
                        
                        if !userPrompt.isEmpty {
                            
                            Button {
                                isFocused = false
                                Task {
                                    await generateResponse()
                                }
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .foregroundStyle(.indigo)
                                    .frame(width: 40, height: 40)
                            }
                            .transition(.scale)
                            
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: userPrompt)
                    
                    .toolbar {
                        
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isFocused = false
                            }
                        }
                    }
                    
                }
                
                .padding()
            }
            
        }
        .environment(\.colorScheme, .light)
    }
    
    
    func generateResponse() async {
        isLoading = true
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No response found")
                userPrompt = ""
            } catch {
                response = "Something went wrong \n \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
