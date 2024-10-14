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
    let backTextScale = 0.3
    let backTextRotation = -10.0
    let backTextShadow = 5.0
    let backTextShadowOffsetX = -3.0
    let backTextShadowOffsetY = 5.0
    let cornerTextScale = 0.2
    let cornerTextFrameScale = 0.3
    let cornerPaddingScale = 0.1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                outerEdge
                cardBackground
                centerEllipse
                centerSymbol
                if card.isFaceUp {
                    cornerSymbols
                }
            }
            .onAppear {
                cardWidth = geometry.size.width
            }
            .onChange(of: geometry.size.width) { oldWidth, newWidth in
                cardWidth = newWidth
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
    }
    
    var outerEdge: some View {
        RoundedRectangle(cornerRadius: baseCornerRadius)
            .fill(.white)
            .strokeBorder(.black)
    }
    
    @ViewBuilder
    var cardBackground: some View {
        let selected = gameManager.isCardSelected(card)
        let backgroundColor: Color = card.isFaceUp ? gameManager.colorForCard(card) : .black
        let backgroundMainColor = selected ? backgroundColor.opacity(sunburstOpacity) : backgroundColor
        let backgroundTransparentColor = selected ? backgroundColor : backgroundColor.opacity(sunburstOpacity)
        RoundedRectangle(cornerRadius: baseCornerRadius + insetScale * cardWidth)
            .inset(by: insetScale * cardWidth)
            .foregroundStyle(AngularGradient(colors: Array(repeating: [backgroundMainColor, backgroundTransparentColor], count: 20).flatMap { $0 }, center: .center))
            .animation(.linear.repeatForever(), value: selected)
        
    }
    
//    [backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor]
    var centerEllipse: some View {
        Ellipse()
            .fill(card.isFaceUp ? .white : .red)
            .frame(width: centerEllipseScale * cardWidth, height: cardWidth)
            .rotationEffect(.degrees(centerEllipseRotation))
    }
    
    @ViewBuilder
    var centerSymbol: some View {
        if card.isFaceUp {
            cardSymbol(withColor: gameManager.colorForCard(card))
                .bold()
                .foregroundStyle(gameManager.colorForCard(card))
                .font(.system(size: frontTextScale * cardWidth))
            
        } else {
            Text("UNO")
                .bold()
                .font(.system(size: backTextScale * cardWidth))
                .foregroundStyle(LinearGradient(colors: [.yellow, .white], startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(backTextRotation))
                .shadow(color: .black, radius: backTextShadow, x: backTextShadowOffsetX, y: backTextShadowOffsetY)
            
        }
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




#Preview {
    CardView(card: UnoGame.Card(color: .blue, type: .drawTwo))
        .environment(UnoGameManager(players: ["Player 1"]))
}
