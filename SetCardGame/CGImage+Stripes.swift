//
//  CGImage+Stripes.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 21.03.2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

extension CGImage {
    // Width is for total, ratio is second stripe relative to full width
    static func stripes(colors: (UIColor, UIColor), width: CGFloat = 2, ratio: CGFloat = 0.25) -> CGImage {
    let filter = CIFilter.stripesGenerator()
    filter.color0 = CIColor(color: colors.0)
    filter.color1 = CIColor(color: colors.1)
    filter.width = Float(width-width*ratio)
    filter.center = CGPoint(x: width, y: 0)
    let size = CGSize(width: width+width*ratio, height: 1)
    let bounds = CGRect(origin: .zero, size: size)
        
    // Keep a reference to a CIContext if calling this often
    return CIContext().createCGImage(filter.outputImage!.clamped(to: bounds), from: bounds)!
  }
}

//extension CGImage {
//
//    static func generateStripePattern(colors: (UIColor, UIColor) = (.clear, .black), width: CGFloat = 5, ratio: CGFloat = 1) -> CGImage? {
//    let context = CIContext()
//    let stripes = CIFilter.stripesGenerator()
//    stripes.color0 = CIColor(color: colors.0)
//    stripes.color1 = CIColor(color: colors.1)
//    stripes.width = Float(width)
//    stripes.center = CGPoint(x: 1-width * ratio, y: 0)
//    let size = CGSize(width: width, height: 1)
//
//    guard let stripesImage = stripes.outputImage, let image = context.createCGImage(stripesImage, from: CGRect(origin: .zero, size: size)) else { return nil }
//    return image
//  }
//
//}
//
//extension Shape {
//
//    func stripes(angle: Double = 0) -> AnyView {
//        guard let stripePattern = CGImage.generateStripePattern() else { return AnyView(self) }
//
//        return AnyView(Rectangle().fill(ImagePaint(image: Image(decorative: stripePattern, scale: 1.0)))
//        .scaleEffect(2)
//        .rotationEffect(.degrees(angle))
//        .clipShape(self))
//    }
//
//}
