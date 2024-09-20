//
//  Adding Codable conformance to @observable class.swift
//  Cupcake Corner
//
//  Created by Sagar Jangra on 28/07/2024.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "Honey"
}


struct Adding_Codable_conformance_to__observable_class: View {
    var body: some View {
        Button("Encode Honey", action: encodeHoney)
    }
    
    func encodeHoney() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        
    }
}

#Preview {
    Adding_Codable_conformance_to__observable_class()
}
