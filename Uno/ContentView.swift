//
//  ContentView.swift
//  Uno
//
//  Created by John Delano on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    let cardSymbols = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ⃠", "↺", "+2", "W", "+4"]
    @State var cardCount = 4
    var body: some View {
        VStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(color: .blue, symbol: cardSymbols[index])
            }
            HStack {
                Button(action: {
                    cardCount += 1
                }, label: {
                    Text("Add\nCard")
                })
                Button(action: {
                    print("tapped Remove Card")
                }, label: {
                    Text("""
                         Remove
                         Card
                         """)
                })
            }
        }
    }
}

struct CardView: View {
    let color: Color
    let symbol: String
    var isFaceUp: Bool = true
    @State var cardWidth: CGFloat = 10
    
    // Constants
    let cardAspectRatio: CGFloat = 2/3
    let baseCornerRadius: CGFloat = 15
    let insetScale: CGFloat = 0.05
    let sunburstOpacity: CGFloat = 0.8
    let centerEllipseScale: CGFloat = 0.75
    let centerEllipseRotation: CGFloat = 45
    let frontTextScale: CGFloat = 0.5
    let backTextScale: CGFloat = 0.3
    let backTextRotation: CGFloat = -10
    let backTextShadow: CGFloat = 5
    let backTextShadowOffsetX: CGFloat = -3
    let backTextShadowOffsetY: CGFloat = 5
    let cornerTextScale: CGFloat = 0.2
    let cornerPaddingScale: CGFloat = 0.1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                outerEdge
                cardBackground
                centerEllipse
                centerSymbol
                if isFaceUp {
                    cornerSymbols
                }
            }
            .onAppear {
                cardWidth = geometry.size.width
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
        let backgroundColor: Color = isFaceUp ? color : .black
        RoundedRectangle(cornerRadius: baseCornerRadius + insetScale * cardWidth)
            .inset(by: insetScale * cardWidth)
            .foregroundStyle(AngularGradient(colors: [backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor,backgroundColor.opacity(sunburstOpacity), backgroundColor], center: .center))

    }
    
    var centerEllipse: some View {
        Ellipse()
            .fill(isFaceUp ? .white : .red)
            .frame(width: centerEllipseScale * cardWidth, height: cardWidth)
            .rotationEffect(.degrees(centerEllipseRotation))
    }

    @ViewBuilder
    var centerSymbol: some View {
        if isFaceUp {
            Text(symbol)
                .bold()
                .foregroundStyle(color)
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
        let symbolText = Text(symbol)
            .font(.system(size: cornerTextScale * cardWidth))
            .bold()
            .foregroundStyle(.white)
        VStack {
            HStack {
                symbolText
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                symbolText
                    .rotationEffect(.degrees(180))
            }
            
        }
        .padding(cornerPaddingScale * cardWidth)

    }
}
        
        
        







#Preview {
    ContentView()

}
