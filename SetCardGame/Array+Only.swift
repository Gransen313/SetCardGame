//
//  Array+Only.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import Foundation

import Foundation

extension Array {
    
    var only: Element? {
        self.count == 1 ? first : nil
    }
    
}
