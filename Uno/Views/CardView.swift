//
//  CardView.swift
//  Uno
//
//  Created by John Delano on 9/23/24.
//

import SwiftUI

struct CardView: View {
    
    let card: UnoGame.Card
    @Environment(UnoGameManager.self) var gameManager
    @State var cardWidth = 10.0
    
    // Constants
    let cardAspectRatio = 2/3.0
    let baseCornerRadius = 15.0
    let insetScale = 0.05
    let sunburstOpacity = 0.8
    let centerEllipseScale = 0.75
    let centerEllipseRotation = 45.0
    let frontTextScale = 0.5
    let cornerTextScale = 0.2
    let cornerTextFrameScale = 0.3
    let cornerPaddingScale = 0.1

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                outerEdge
                cardBackground(withColor: gameManager.colorForCard(card))
                centerEllipse(withColor: .white)
                frontCenterSymbol
                cornerSymbols
            }
            .onAppear {
                cardWidth = geometry.size.width
            }
            .onChange(of: geometry.size.width) { oldWidth, newWidth in
                cardWidth = newWidth
            }
        }
    }
    
    var outerEdge: some View {
        RoundedRectangle(cornerRadius: baseCornerRadius)
            .fill(.white)
            .strokeBorder(.black)
    }
    
    @ViewBuilder
    func cardBackground(withColor color: Color) -> some View {
        let selected = gameManager.isCardSelected(card)
        let backgroundMainColor = selected ? color.opacity(sunburstOpacity) : color
        let backgroundTransparentColor = selected ? color : color.opacity(sunburstOpacity)
        RoundedRectangle(cornerRadius: baseCornerRadius + insetScale * cardWidth)
            .inset(by: insetScale * cardWidth)
            .foregroundStyle(AngularGradient(colors: Array(repeating: [backgroundMainColor, backgroundTransparentColor], count: 20).flatMap { $0 }, center: .center))
            .animation(.linear.repeatForever().when(selected), value: selected)
    }
    
    @ViewBuilder
    func centerEllipse(withColor color: Color) -> some View {
        Ellipse()
            .fill(color)
            .frame(width: centerEllipseScale * cardWidth, height: cardWidth)
            .rotationEffect(.degrees(centerEllipseRotation))
    }
    
    @ViewBuilder
    var frontCenterSymbol: some View {
        cardSymbol(withColor: gameManager.colorForCard(card))
            .bold()
            .foregroundStyle(gameManager.colorForCard(card))
            .font(.system(size: frontTextScale * cardWidth))
    }
    
    @ViewBuilder
    var cornerSymbols: some View {
        let symbol = cardSymbol(withColor: .white)
            .font(.system(size: cornerTextScale * cardWidth))
            .frame(width: cornerTextFrameScale * cardWidth)
            .bold()
            .foregroundStyle(.white)
        VStack {
            HStack {
                symbol
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                symbol
                    .rotationEffect(.degrees(180))
            }
            
        }
        .padding(cornerPaddingScale * cardWidth)
        
    }
    
    @ViewBuilder
    func cardSymbol(withColor color: Color) -> some View {
        switch card.type {
            case .skip:
                SkipSymbol(color: color)
            case .reverse:
                ReverseSymbol(color: color)
            default:
                Text(card.symbol)
                    .underline(card.symbol == "6" || card.symbol == "9")
        }
    }
}

extension Animation {
    func when(_ condition: Bool) -> Animation? {
        condition ? self : .linear(duration: 0.0)
    }
}


#Preview {
    CardView(card: UnoGame.Card(color: .blue, type: .drawTwo, isFaceUp: true))
        .environment(UnoGameManager(players: ["Player 1"]))
}
