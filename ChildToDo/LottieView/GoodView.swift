//
//  GoodView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/13.
//

import SwiftUI
import Lottie

struct GoodView: UIViewRepresentable {

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    func makeUIView(context: Context) -> UIView {
        let view = LottieAnimationView(name: "good")
        view.translatesAutoresizingMaskIntoConstraints = false

        let parentView = UIView()
        parentView.addSubview(view)
        parentView.addConstraints([
            view.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ])

        view.play()
        view.loopMode = .playOnce

        return parentView
    }
}
