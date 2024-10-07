//
//  AddingSwiftPackageDependicies.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 08/10/2024.
//

// .random is imported function 
import SamplePackage
import SwiftUI

struct AddingSwiftPackageDependicies: View {
    let possibleNumbers = 1...60
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        Text(results)
    }
}

#Preview {
    AddingSwiftPackageDependicies()
}
