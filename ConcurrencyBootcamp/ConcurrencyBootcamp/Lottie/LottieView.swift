////
////  LottieView.swift
////  ConcurrencyBootcamp
////
////  Created by Sagar Jangra on 25/01/2026.
////
//
//
//import SwiftUI
//import Lottie
//
//struct LottieView: UIViewRepresentable {
//
//    let animationName: String
//    let loopMode: LottieLoopMode
//
//    func makeUIView(context: Context) -> UIView {
//        let containerView = UIView()
//
//        let animationView = LottieAnimationView(
//            name: animationName,
//            bundle: .main
//        )
//
//        animationView.loopMode = loopMode
//        animationView.contentMode = .scaleAspectFit
//        animationView.play()
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(animationView)
//
//        NSLayoutConstraint.activate([
//            animationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            animationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            animationView.topAnchor.constraint(equalTo: containerView.topAnchor),
//            animationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//        ])
//
//        return containerView
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {}
//}
