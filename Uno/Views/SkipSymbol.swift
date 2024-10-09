//
//  SkipSymbol.swift
//  Uno
//
//  Created by John Delano on 10/9/24.
//

import SwiftUI

struct SkipShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addEllipse(in: rect)
        
        var linePath = Path()
        let circleRadius = Double(min(rect.width, rect.height) / 2)
        let circleCenter = CGPoint(x: rect.midX, y: rect.midY)
        let lineAngle = Angle(degrees: -45.0).radians
        linePath.move(to: CGPoint(x: circleCenter.x - circleRadius * cos(lineAngle), y: circleCenter.x - circleRadius * sin(lineAngle)))
        linePath.addLine(to: CGPoint(x: circleCenter.x + circleRadius * cos(lineAngle), y: circleCenter.x + circleRadius * sin(lineAngle)))
        
        path.addPath(linePath)
        return path.applying(CGAffineTransform(scaleX: 0.5, y: 0.5).translatedBy(x: rect.width / 2, y: rect.height / 2))
    }
}

struct SkipSymbol: View {
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            SkipShape()
                .stroke(color, lineWidth: geometry.size.width * 0.05)
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    SkipSymbol(color: .blue)
}
