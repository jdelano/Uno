//
//  ContentView.swift
//  Uno
//
//  Created by John Delano on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(UnoGameManager.self) var gameManager
    
    var body: some View {
        VStack {
            handForPlayer(playerIndex: 0)
            Spacer()
            Button("Reset") {
                gameManager.resetGame()
            }
            Spacer()
            handForPlayer(playerIndex: 1)
        }
        
    }
    
    func handForPlayer(playerIndex: Int) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: -50) {
                ForEach(gameManager.cards(forPlayerIndex: playerIndex)) { card in
                    CardView(card: card)
                }
            }
        }
    }
    
}

 







#Preview {
    ContentView()
        .environment(UnoGameManager(players: ["Player 1", "Player 2"]))

}
