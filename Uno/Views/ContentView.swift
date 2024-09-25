//
//  ContentView.swift
//  Uno
//
//  Created by John Delano on 8/26/24.
//

import SwiftUI

struct ContentView: View {
//    let cardSymbols = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ⃠", "↺", "+2", "W", "+4"]
//    @State var cardCount = 4
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
