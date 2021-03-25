//
//  Oval.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 23.03.2021.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let roundedRectangle = RoundedRectangle(cornerRadius: rect.height)
        
        return roundedRectangle.path(in: rect)
    }
    
}
