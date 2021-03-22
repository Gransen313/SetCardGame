//
//  AnyShape+setShading.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 22.03.2021.
//

import SwiftUI

struct AnyShape: Shape {
    private var base: (CGRect) -> Path
    public init<S: Shape>(shape: S) {
        base = shape.path(in:)
    }
    public func path(in rect: CGRect) -> Path {
        base(rect)
    }
}

extension Shape {
    func setShading(shading: Shading, color: Color, scale: CGFloat = 1.0, lineWidth: CGFloat) -> some View {
        var view: some View {
            switch shading {
            case .open: return AnyView(self)
            case .striped: return AnyView(self.fill(ImagePaint(image: Image(decorative: CGImage.stripes(colors: (UIColor(color), .clear)), scale: scale))))
            case .solid: return AnyView(self.fill())
            }
        }
        return view.overlay(self.stroke(lineWidth: lineWidth))
    }
}
