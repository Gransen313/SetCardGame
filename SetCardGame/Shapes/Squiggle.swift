//
//  Squiggle.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 23.03.2021.
//

import SwiftUI

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let width: CGFloat = rect.maxX - rect.minX
        let divider: CGFloat = 8.5 + sqrt(12.5) + sqrt(11.25) - sqrt(8)
        let unit: CGFloat  = width / divider
        
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        let centerFirstArc = CGPoint(x: startPoint.x + unit * 2, y: startPoint.y)
        let radiusFirstArc = CGFloat(2 * unit)
        let startAngleFirstArc = Angle(degrees: 180)
        let endAngleFirstArc = Angle(degrees: 225)
        let clockwiseFirstArc = false
        
        let centerSecondArc = CGPoint(x: startPoint.x + unit * 4, y: startPoint.y + unit * 2)
        let radiusSecondArc = CGFloat((2 + sqrt(8)) * unit)
        let startAngleSecondArc = Angle(degrees: 225)
        let endAngleSecondArc = Angle(degrees: 270)
        let clockwiseSecondArc = false
        
        let centerThirdArc = CGPoint(x: startPoint.x + unit * 4, y: startPoint.y)
        let radiusThirdArc = CGFloat(sqrt(8) * unit)
        let startAngleThirdArc = Angle(degrees: 270)
        let endAngleThirdArc = Angle(degrees: 315)
        let clockwiseThirdArc = false
        
        let centerForthArc = CGPoint(x: startPoint.x + unit * 8, y: startPoint.y - unit * 4)
        let radiusForthArc = CGFloat(sqrt(8) * unit)
        let startAngleForthArc = Angle(degrees: 135)
        let endAngleForthArc = Angle(degrees: 30)
        let clockwiseForthArc = true
        
        let centerFifthArc = CGPoint(x: startPoint.x + unit * 11, y: startPoint.y - unit * 2.5)
        let radiusFifthArc = CGFloat((sqrt(11.25) - sqrt(8)) * unit)
        let startAngleFifthArc = Angle(degrees: 210)
        let endAngleFifthArc = Angle(degrees: -45)
        let clockwiseFifthArc = false
        
        let centerSixthArc = CGPoint(x: startPoint.x + unit * 8.5, y: startPoint.y)
        let radiusSixthArc = CGFloat((sqrt(12.5) + sqrt(11.25) - sqrt(8)) * unit)
        let startAngleSixthArc = Angle(degrees: -45)
        let endAngleSixthArc = Angle(degrees: 0)
        let clockwiseSixthArc = false
        
        let centerSeventhArc = CGPoint(x: endPoint.x - unit * 2, y: endPoint.y)
        let radiusSeventhArc = CGFloat(2 * unit)
        let startAngleSeventhArc = Angle(degrees: 0)
        let endAngleSeventhArc = Angle(degrees: 45)
        let clockwiseSeventhArc = false
        
        let centerEighthArc = CGPoint(x: endPoint.x - unit * 4, y: endPoint.y - unit * 2)
        let radiusEighthArc = CGFloat((2 + sqrt(8)) * unit)
        let startAngleEighthArc = Angle(degrees: 45)
        let endAngleEighthArc = Angle(degrees: 90)
        let clockwiseEighthArc = false
        
        let centerNinethArc = CGPoint(x: endPoint.x - unit * 4, y: endPoint.y)
        let radiusNinethArc = CGFloat(sqrt(8) * unit)
        let startAngleNinethArc = Angle(degrees: 90)
        let endAngleNinethArc = Angle(degrees: 135)
        let clockwiseNinethArc = false
        
        let centerTenthArc = CGPoint(x: endPoint.x - unit * 8, y: endPoint.y + unit * 4)
        let radiusTenthArc = CGFloat(sqrt(8) * unit)
        let startAngleTenthArc = Angle(degrees: -45)
        let endAngleTenthArc = Angle(degrees: 210)
        let clockwiseTenthArc = true
        
        let centerEleventhArc = CGPoint(x: endPoint.x - unit * 11, y: endPoint.y + unit * 2.5)
        let radiusEleventhArc = CGFloat((sqrt(11.25) - sqrt(8)) * unit)
        let startAngleEleventhArc = Angle(degrees: 30)
        let endAngleEleventhArc = Angle(degrees: 135)
        let clockwiseEleventhArc = false
        
        let centerTwelfthArc = CGPoint(x: endPoint.x - unit * 8.5, y: endPoint.y)
        let radiusTwelfthArc = CGFloat((sqrt(12.5) + sqrt(11.25) - sqrt(8)) * unit)
        let startAngleTwelfthArc = Angle(degrees: 135)
        let endAngleTwelfthArc = Angle(degrees: 180)
        let clockwiseTwelfthArc = false
        
        var path = Path()
        path.move(to: startPoint)
        path.addArc(center: centerFirstArc, radius: radiusFirstArc, startAngle: startAngleFirstArc, endAngle: endAngleFirstArc, clockwise: clockwiseFirstArc)
        path.addArc(center: centerSecondArc, radius: radiusSecondArc, startAngle: startAngleSecondArc, endAngle: endAngleSecondArc, clockwise: clockwiseSecondArc)
        path.addArc(center: centerThirdArc, radius: radiusThirdArc, startAngle: startAngleThirdArc, endAngle: endAngleThirdArc, clockwise: clockwiseThirdArc)
        path.addArc(center: centerForthArc, radius: radiusForthArc, startAngle: startAngleForthArc, endAngle: endAngleForthArc, clockwise: clockwiseForthArc)
        path.addArc(center: centerFifthArc, radius: radiusFifthArc, startAngle: startAngleFifthArc, endAngle: endAngleFifthArc, clockwise: clockwiseFifthArc)
        path.addArc(center: centerSixthArc, radius: radiusSixthArc, startAngle: startAngleSixthArc, endAngle: endAngleSixthArc, clockwise: clockwiseSixthArc)
        path.addArc(center: centerSeventhArc, radius: radiusSeventhArc, startAngle: startAngleSeventhArc, endAngle: endAngleSeventhArc, clockwise: clockwiseSeventhArc)
        path.addArc(center: centerEighthArc, radius: radiusEighthArc, startAngle: startAngleEighthArc, endAngle: endAngleEighthArc, clockwise: clockwiseEighthArc)
        path.addArc(center: centerNinethArc, radius: radiusNinethArc, startAngle: startAngleNinethArc, endAngle: endAngleNinethArc, clockwise: clockwiseNinethArc)
        path.addArc(center: centerTenthArc, radius: radiusTenthArc, startAngle: startAngleTenthArc, endAngle: endAngleTenthArc, clockwise: clockwiseTenthArc)
        path.addArc(center: centerEleventhArc, radius: radiusEleventhArc, startAngle: startAngleEleventhArc, endAngle: endAngleEleventhArc, clockwise: clockwiseEleventhArc)
        path.addArc(center: centerTwelfthArc, radius: radiusTwelfthArc, startAngle: startAngleTwelfthArc, endAngle: endAngleTwelfthArc, clockwise: clockwiseTwelfthArc)
        
        return path
    }
    
}

