//
//  HomeView.swift
//  Uno
//
//  Created by John Delano on 11/6/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to UNO!")
                    .font(.largeTitle)
                    .padding()
                NavigationLink(value: GameRoute.game) {
                    homePageOption("Start New Game", color: .blue)
                }
                NavigationLink(value: GameRoute.instructions) {
                    homePageOption("Intructions", color: .green)

                }
                NavigationLink(value: GameRoute.settings) {
                    homePageOption("Settings", color: .orange)

                }
            }
            .padding()
            .navigationDestination(for: GameRoute.self) { route in
                switch route {
                    case .game: GameView()
                    case .instructions: InstructionsView()
                    case .settings: SettingsView()
                }
            }
        }
    }
    
    func homePageOption(_ text: String, color: Color) -> some View {
        Text(text)
            .font(.title)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundStyle(.white)
            .cornerRadius(10)
    }
}
