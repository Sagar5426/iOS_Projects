//
//  adding annotion on tap.swift
//  Bucket List
//
//  Created by Sagar Jangra on 23/08/2024.
//

import SwiftUI
import MapKit

struct adding_annotion_on_tap: View {
    var body: some View {
        VStack {
            MapReader { proxy in
                Map()
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            print(coordinate)
                        }
                    }
            }
        }
    }
}

#Preview {
    adding_annotion_on_tap()
}
