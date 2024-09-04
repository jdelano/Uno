//
//  ContentView.swift
//  Uno
//
//  Created by John Delano on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CardView()
            HStack {
                CardView()
                CardView()
            }
            HStack {
                CardView()
                CardView()
                CardView()
                CardView()
                CardView()
                CardView()
            }
        }
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    @State var cardWidth: CGFloat = 10
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
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    var outerEdge: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.white)
            .strokeBorder(.black, lineWidth: 2)
    }
    
    @ViewBuilder
    var cardBackground: some View {
        let backgroundColor: Color = isFaceUp ? .blue : .black
        RoundedRectangle(cornerRadius: 25)
            .inset(by: 10)
            .foregroundStyle(AngularGradient(colors: [backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,backgroundColor.opacity(0.8), backgroundColor,], center: .center))

    }
    
    var centerEllipse: some View {
        Ellipse()
            .fill(isFaceUp ? .white : .red)
            .frame(width: 0.75 * cardWidth, height: cardWidth)
            .rotationEffect(.degrees(45))
    }

    @ViewBuilder
    var centerSymbol: some View {
        if isFaceUp {
            Text("5")
                .bold()
                .foregroundStyle(.blue)
                .font(.system(size: 0.5 * cardWidth))

        } else {
            Text("UNO")
                .bold()
                .font(.system(size: 0.3 * cardWidth))
                .foregroundStyle(LinearGradient(colors: [.yellow, .white], startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(-10))
                .shadow(color: .black, radius: 5, x: -3, y: 5)

        }
    }
    
    @ViewBuilder
    var cornerSymbols: some View {
        let symbolText = Text("5")
            .font(.system(size: 0.2 * cardWidth))
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
        .padding(0.1 * cardWidth)

    }
}
        
        
        







#Preview {
    ContentView()

}
