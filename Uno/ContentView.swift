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
            Grid {
                GridRow {
                    ForEach(0..<cardCount, id: \.self) { index in
                        CardView(color: .blue, symbol: cardSymbols[index])
                    }

                }
            }
            Spacer()
            Grid {
                GridRow {
                    
                    ForEach(0..<cardCount, id: \.self) { index in
                        CardView(color: .blue, symbol: cardSymbols[index])
                    }

                }
            }
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                
//            }
        }
        VStack {
            HStack {
                add
                Spacer()
                remove
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
           cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > cardSymbols.count)
    }
    
    var add: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    var remove: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")

    }
}

struct CardView: View {
    let color: Color
    let symbol: String
    var isFaceUp: Bool = true
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
    let cornerPaddingScale = 0.1
    
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
