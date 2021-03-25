//
//  Array+Identifieble.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
}
