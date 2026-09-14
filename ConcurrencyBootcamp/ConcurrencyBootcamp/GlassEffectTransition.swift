//
//  SwiftUIView.swift
//  ConcurrencyBootcamp
//
//  Created by Sagar Jangra on 18/03/2026.
//

import SwiftUI

struct GlassEffectTransition: View {
    @State private var isExpanded = false
    @Namespace var namespace
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                GlassEffectContainer {
                    HStack {
                        
                        
                        if isExpanded {
                            Group {
                                Image(systemName: "building.2")
                                    .font(.system(size: 36))
                                    .frame(width: 80, height: 80)
                                    .glassEffectID("building", in: namespace)
                                
                                
                                Image(systemName: "fish")
                                    .font(.system(size: 36))
                                    .frame(width: 80, height: 80)
                                    .glassEffectID("fish", in: namespace)
                            }
                            .glassEffect(.regular.tint(.yellow.opacity(0.4)).interactive())
                            .glassEffectUnion(id: 1, namespace: namespace)
                            .glassEffectTransition(.matchedGeometry)
                        }
                        Image(systemName: "photo")
                            .font(.system(size: 36))
                            .frame(width: 80, height: 80)
                            .glassEffect(.regular.tint(.teal.opacity(0.4)).interactive())
                            .glassEffectID("photo", in: namespace)
                            .onTapGesture {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .background(Color.black)
        }
    }
}

#Preview {
    GlassEffectTransition()
}
