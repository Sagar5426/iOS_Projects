//
//  Writing data to documents directory.swift
//  Bucket List
//
//  Created by Sagar Jangra on 22/08/2024.

//  Writing data to local directory a low level of storing data compared to swift data but it had used in many apps in market

import SwiftUI

struct Writing_data_to_documents_directory: View {
    var body: some View {
        VStack {
            Button("Read and Write") {
                let data = Data("Test Message".utf8)
                let url = URL.documentsDirectory.appending(path: "message.txt")
                
                do {
                    //writing
                    try data.write(to: url, options: [.atomic, .completeFileProtection])
                    // reading
                    let input = try String(contentsOf: url)
                    print(input)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func test() {
        print(URL.documentsDirectory)
    }
}

#Preview {
    Writing_data_to_documents_directory()
}
