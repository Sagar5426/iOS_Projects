//
//  CreatingContextMenus.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 07/10/2024.
//

import SwiftUI

struct CreatingContextMenus: View {
    
    enum myColor: String, CaseIterable {
        case red, green, blue
        
        var color: Color {
            switch self {
            case .red: return .red
            case .green: return .green
            case .blue: return .blue
            }
        }
    }
    
    @State private var backgroundColor: Color = .red
    @State private var selected: myColor = .red
    
    var body: some View {
        VStack {
            Text("Long Press")
                .padding()
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .background(backgroundColor)
                .clipShape(.capsule)
                .contextMenu {
                    
                    ForEach(myColor.allCases, id: \.self) { color in
                        Button(color.rawValue.capitalized, systemImage: color == selected ? "checkmark.circle.fill" : "") {
                            selected = color
                            backgroundColor = color.color
                        }
                    }
                }
            
                
        }
    }
}

#Preview {
    CreatingContextMenus()
}
