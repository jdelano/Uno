//
//  ContentView.swift
//  Uno
//
//  Created by John Delano on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    var isFaceUp: Bool = true
    var body: some View {
        if isFaceUp {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .strokeBorder(.black, lineWidth: 2)
                    .padding()
                RoundedRectangle(cornerRadius: 25)
                    .inset(by: 10)
                    .foregroundStyle(AngularGradient(colors: [.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,.blue.opacity(0.8), .blue,], center: .center))
                    .padding()
                Ellipse()
                    .fill(.white)
                    .frame(width: 250, height: 415)
                    .rotationEffect(.degrees(45))
                Text("5")
                    .bold()
                    .foregroundStyle(.blue)
                    .font(.system(size: 250))
                VStack {
                    HStack {
                        Text("5")
                            .font(.system(size: 70))
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text("5")
                            .font(.system(size: 70))
                            .bold()
                            .foregroundStyle(.white)
                            .rotationEffect(.degrees(180))
                            .padding()
                    }
                    
                }
                .padding()
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .strokeBorder(.black, lineWidth: 2)
                    .padding()
                RoundedRectangle(cornerRadius: 25)
                    .inset(by: 10)
                    .fill(.black)
                    .padding()
                Ellipse()
                    .fill(.red)
                    .frame(width: 250, height: 415)
                    .rotationEffect(.degrees(45))
                Text("UNO")
                    .bold()
                    .font(.system(size: 100))
                    .foregroundStyle(LinearGradient(colors: [.yellow, .white], startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(-10))
                    .shadow(color: .black, radius: 5, x: -3, y: 5)
                
            }
        }
    }
}








#Preview {
    ContentView()

}
