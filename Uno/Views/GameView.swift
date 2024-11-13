//
//  GameView.swift
//  Uno
//
//  Created by John Delano on 11/6/24.
//

import SwiftUI

struct GameView: View {
    @Environment(UnoGameManager.self) var gameManager
    
    @Environment(\.dismiss) var dismiss
    var isNewGame: Bool = true
    
    var body: some View {
        VStack {
            // player name #1
            Text("\(gameManager.playerNames[0])")
            // Content
            ContentView()
            //Player name #2
            Text("\(gameManager.playerNames[1])")
            // Button (I Quit)
            Button("End Game") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if isNewGame {
                gameManager.resetGame()
            }
        }
    }
}

#Preview {
    GameView()
        .environment(UnoGameManager(players: ["Player 1", "Player 2"]))
}
