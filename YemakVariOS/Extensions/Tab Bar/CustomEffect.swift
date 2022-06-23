//
//  CustomEffect.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 23.04.22.
//

import SwiftUI

struct CustomEffect: UIViewRepresentable{
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView{
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
