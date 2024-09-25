//
//  UnoApp.swift
//  Uno
//
//  Created by John Delano on 8/26/24.
//

import SwiftUI

@main
struct UnoApp: App {
    @State var gameManager = UnoGameManager(players: ["Player 1", "Player 2"])
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameManager)
        }
    }
}
