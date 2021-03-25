//
//  Diamond.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 23.03.2021.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let bottomPoint: CGPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let topPoint: CGPoint = CGPoint(x: rect.midX, y: rect.minY)
        let leadingPoint: CGPoint = CGPoint(x: rect.minX, y: rect.midY)
        let trailingPoint: CGPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        var path = Path()
        path.move(to: topPoint)
        path.addLine(to: leadingPoint)
        path.addLine(to: bottomPoint)
        path.addLine(to: trailingPoint)
        path.addLine(to: topPoint)
        
        return path
    }
    
}
