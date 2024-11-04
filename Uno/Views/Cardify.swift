//
//  Cardify.swift
//  Uno
//
//  Created by John Delano on 11/3/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private var rotation: Double
    
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
    let backTextScale = 0.3
    let backTextRotation = -10.0
    let backTextShadow = 5.0
    let backTextShadowOffsetX = -3.0
    let backTextShadowOffsetY = 5.0

    var isFaceUp: Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                outerEdge
                if isFaceUp {
                    content
                } else {
                    Group {
                        cardBackground(withColor: .black)
                        centerEllipse(withColor: .red)
                        backCenterSymbol
                    }
                    .rotation3DEffect(.degrees(isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
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
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))

    }
    
    var outerEdge: some View {
        RoundedRectangle(cornerRadius: baseCornerRadius)
            .fill(.white)
            .strokeBorder(.black)
    }
    
    @ViewBuilder
    func cardBackground(withColor color: Color) -> some View {
        let backgroundMainColor = color
        let backgroundTransparentColor = color.opacity(sunburstOpacity)
        RoundedRectangle(cornerRadius: baseCornerRadius + insetScale * cardWidth)
            .inset(by: insetScale * cardWidth)
            .foregroundStyle(AngularGradient(colors: Array(repeating: [backgroundMainColor, backgroundTransparentColor], count: 20).flatMap { $0 }, center: .center))
    }
    
    @ViewBuilder
    func centerEllipse(withColor color: Color) -> some View {
        Ellipse()
            .fill(color)
            .frame(width: centerEllipseScale * cardWidth, height: cardWidth)
            .rotationEffect(.degrees(centerEllipseRotation))
    }
    
    @ViewBuilder
    var backCenterSymbol: some View {
        Text("UNO")
            .bold()
            .font(.system(size: backTextScale * cardWidth))
            .foregroundStyle(LinearGradient(colors: [.yellow, .white], startPoint: .top, endPoint: .bottom))
            .rotationEffect(.degrees(backTextRotation))
            .shadow(color: .black, radius: backTextShadow, x: backTextShadowOffsetX, y: backTextShadowOffsetY)
        
    }


}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
