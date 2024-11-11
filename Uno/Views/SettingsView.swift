//
//  SettingsView.swift
//  Uno
//
//  Created by John Delano on 11/6/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(UnoGameManager.self) var gameManager
    
    var body: some View {
        @Bindable var gameManager = gameManager
        Form {
            Section(header: Text("Player Names")) {
                ForEach(gameManager.playerNames.indices, id:\.self) { index in
                    TextField("Player \(index + 1)", text: $gameManager.playerNames[index])
                }
            }
        }
    }
}
