//
//  GuessNumberGameApp.swift
//  GuessNumberGame
//
//  Created by Facheng Liang on 2021/7/29.
//

import SwiftUI

@main
struct GuessNumberGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: GameViewModel())
        }
    }
}
