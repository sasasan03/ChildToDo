//
//  LottieView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/13.
//

import SwiftUI
import Lottie

enum LottieFileType: String {
    case good = "good"
    case loading = "elephant"
}

struct LottieView: UIViewRepresentable {
    let resourceType: LottieFileType

    func updateUIView(_ uiView: UIView, context: Context) { }

    func makeUIView(context: Context) -> UIView {
        
        let view = LottieAnimationView(name: resourceType.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false

        let parentView = UIView()
        parentView.addSubview(view)
        parentView.addConstraints([
            view.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ])
        
        switch resourceType {
        case .good:
            view.play()
            view.loopMode = .playOnce
        case .loading:
            view.play()
            view.loopMode = .loop
        }

        return parentView
    }
}
