//
//  Controlling_Image_Interpolation.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 20/09/2024.
//

import SwiftUI

struct Controlling_Image_Interpolation: View {
    var body: some View {
        Image(.example)
            .interpolation(.none)  // for tiny images -> maintains pixelated look rather than blending pixels they just get scaled up with sharp edges.
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

#Preview {
    Controlling_Image_Interpolation()
}
