//
//  LottieBootcamp.swift
//  ConcurrencyBootcamp
//
//  Created by Sagar Jangra on 26/01/2026.
//

import SwiftUI
import Lottie

// .json -> old
// .dotLottie -> new

struct LottieHelperView: View {
    var fileName: String = "Beach.json"
    var contentMode: UIView.ContentMode = .scaleAspectFit
    var playLoopMode: LottieLoopMode = .loop
    var onAnimationDidFinish: (() -> Void)? = nil
    
    
    var body: some View {
        LottieView(animation: .named(fileName))
            .configure({ lottieAnimationView in
                lottieAnimationView.contentMode = contentMode
            })
            .playbackMode(.playing(.toProgress(1, loopMode: playLoopMode)))
            .animationDidFinish { completed in
                onAnimationDidFinish?()
            }
        
    }
}

#Preview {
    LottieHelperView()
} 
