//
//  ReverseSymbol.swift
//  Uno
//
//  Created by John Delano on 10/9/24.
//

import SwiftUI

struct ReverseArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let shaftThickness = rect.height * 0.1
        let halfShaftThickness = shaftThickness / 2.0
        let shaftLength = rect.width * 0.4
        let halfShaftLength = shaftLength / 2.0
        let shaftXOffset = rect.width * 0.01
        let shaftYOffset = rect.height * 0.06
        
        let shaftRect = CGRect(x: -halfShaftLength, y: -halfShaftThickness, width: shaftLength, height: shaftThickness)
        var shaftPath = Path()
        shaftPath.addRoundedRect(in: shaftRect, cornerRadii: RectangleCornerRadii(topLeading: 25))
        
        // Arrowhead
        let arrowHeadBase: Double = rect.width * 0.25
        let arrowHeadLength = arrowHeadBase / 2.0 // Arrows are half as pointy as they are wide
        let halfArrowHeadLength = arrowHeadLength / 2.0
        let arrowHeadRect = CGRect(x: -arrowHeadLength / 2.0, y: -arrowHeadBase / 2.0, width: arrowHeadLength, height: arrowHeadBase)
        var arrowHeadPath = Path()
        arrowHeadPath.move(to: arrowHeadRect.origin)
        arrowHeadPath.addLine(to: CGPoint(x: arrowHeadRect.origin.x, y: arrowHeadRect.origin.y + arrowHeadBase))
        arrowHeadPath.addLine(to: CGPoint(x: arrowHeadRect.origin.x + arrowHeadLength, y: arrowHeadRect.origin.y + arrowHeadLength))
        arrowHeadPath.closeSubpath()
        
        
        path.addPath(shaftPath.applying(CGAffineTransform(translationX: shaftXOffset, y: -shaftYOffset)))
        path.addPath(shaftPath.applying(CGAffineTransform(translationX: -shaftXOffset, y: shaftYOffset).rotated(by: .pi)))
        path.addPath(arrowHeadPath.applying(CGAffineTransform(translationX: halfShaftLength + halfArrowHeadLength + shaftXOffset, y: -shaftYOffset)))
        path.addPath(arrowHeadPath.applying(CGAffineTransform(translationX: -halfShaftLength - halfArrowHeadLength - shaftXOffset, y: shaftYOffset).rotated(by: .pi)))

        return path.applying(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2).rotated(by: .pi / -4))
    }
    
    
}

struct ReverseSymbol: View {
    var color: Color
    var body: some View {
        ReverseArrowShape()
            .fill(color)
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ReverseSymbol(color: .blue)
}
