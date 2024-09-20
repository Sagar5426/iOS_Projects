//
//  Understanding_Swift_ResultType.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 20/09/2024.
//

import SwiftUI

struct Understanding_Swift_ResultType: View {
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    
    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let success):
            output = success
        case .failure(let failure):
            output = "Error: \(failure.localizedDescription)"
        }
    }
    
}

#Preview {
    Understanding_Swift_ResultType()
}
