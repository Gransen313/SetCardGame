//
//  SetCardGameApp.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

@main
struct SetCardGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: SetGameViewModel())
        }
    }
}
