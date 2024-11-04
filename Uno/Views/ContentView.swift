//
//  ContentView.swift
//  Uno
//
//  Created by John Delano on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(UnoGameManager.self) var gameManager
    typealias Card = UnoGame.Card
    @State var draggedCard: Card?
    @GestureState var dragOffset: CGSize = .zero
    @State private var discardPileFrame: CGRect = .zero
    
    var body: some View {
        @Bindable var gameManager = gameManager

            VStack {
                handForPlayer(playerIndex: 0)
                    .zIndex(gameManager.currentPlayerIndex == 0 ? 1 : 0)
                Spacer()
                HStack {
                    deck
                        .onTapGesture {
                            gameManager.dealCard()
                        }
                    discardPileView
                        .frame(height: 100)
                        .overlay(discardPileFrameTracker)
                }
                Spacer()
                handForPlayer(playerIndex: 1)
                    .zIndex(gameManager.currentPlayerIndex == 1 ? 1 : 0)
            }
            .actionSheet(isPresented: $gameManager.isChoosingColor) {
                colorChooser
            }
    }
    
    func handForPlayer(playerIndex: Int) -> some View {
        LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(gameManager.cards(forPlayerIndex: playerIndex)) { card in
                CardView(card: card)
                    .cardify(isFaceUp: card.isFaceUp)
                    .zIndex(draggedCard == card ? 1 : 0)
                    .offset(draggedCard == card && gameManager.currentPlayerIndex == playerIndex ? dragOffset : .zero)
                    .onTapGesture {
                        gameManager.toggleSelectedCard(card)
                    }
                    .gesture(dragGesture(for: card))
            }
            .id(draggedCard)
        }
        .layoutPriority(1)
    }
    
    var discardPileView: some View {
        ZStack {
            if let topCard = gameManager.topDiscardCard {
                CardView(card: topCard)
                    .cardify(isFaceUp: topCard.isFaceUp)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.red)
                Text("Discard")
                    .foregroundStyle(.white)
            }
        }
        .shadow(color: gameManager.wildColor, radius: 10)
    }
    
    
    var deck: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
            Text("Deck")
                .foregroundStyle(.white)
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    func dragGesture(for card: Card) -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                if draggedCard == nil {
                    draggedCard = card
                }
                if discardPileFrame.contains(value.location) {
                    
                }
            }
            .updating($dragOffset) { value, dragOffset, _  in
                dragOffset = value.translation
            }
            .onEnded { value in
                handleDrop(for: card, at: value.location)
                draggedCard = nil
            }
    }
    
    var discardPileFrameTracker: some View {
        GeometryReader { geometry in
            Color.clear
                .onAppear {
                    self.discardPileFrame = geometry.frame(in: .global)
                }
                .onChange(of: geometry.frame(in: .global)) { _, newFrame in
                    self.discardPileFrame = newFrame
                }
        }
        .overlay(
            Rectangle()
                .strokeBorder(Color.red, lineWidth: draggedCard != nil ? 3 : 0)
                .opacity(0.3)
        )
    }

    // Handle Drop Logic
    func handleDrop(for card: Card, at location: CGPoint) {
        print("Drop handling...")
        print("Discard Pile Frame:", discardPileFrame)
        print("Drop Location:", location)
        
        if discardPileFrame.contains(location) {
            // If the card is dropped within the discard pile's area, make a play
            withAnimation {
                gameManager.playCard(card)
            }
        }
    }
    
    var colorChooser: ActionSheet {
        ActionSheet(title: Text("Choose a Color"),
                    message: Text("Select a color for the wild card"),
                    buttons: [
                        .default(Text("Red")) { gameManager.chooseWildColor(.red) },
                         .default(Text("Green")) { gameManager.chooseWildColor(.green)},
                          .default(Text("Yellow")) { gameManager.chooseWildColor(.yellow)},
                           .default(Text("Blue")) { gameManager.chooseWildColor(.blue)}
                    ])
    }
}

 







#Preview {
    ContentView()
        .environment(UnoGameManager(players: ["Player 1", "Player 2"]))

}
