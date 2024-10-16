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
            HStack {
                Button("Reset") {
                    gameManager.resetGame()
                }
                Button("Next Player") {
                    withAnimation {
                        gameManager.nextPlayer()
                    }
    
                }

            }
            Spacer()
            handForPlayer(playerIndex: 1)
        }
        
    }
    
    func handForPlayer(playerIndex: Int) -> some View {
        LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(gameManager.cards(forPlayerIndex: playerIndex)) { card in
                CardView(card: card)
                    .rotation3DEffect(Angle(degrees: card.isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                    .onTapGesture {
                        gameManager.toggleSelectedCard(card)
                    }
            }
        }
        .layoutPriority(1)
    }
    
}

 







#Preview {
    ContentView()
        .environment(UnoGameManager(players: ["Player 1", "Player 2"]))

}
