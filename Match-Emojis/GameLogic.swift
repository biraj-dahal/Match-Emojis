//
//  GameLogic.swift
//  Match-Emojis
//
//  Created by Biraj Dahal on 2/17/25.
//

import SwiftUI

class GameLogic: ObservableObject {
    @Published var flippedTiles: Set<UUID> = []
    @Published var matchedTiles: Set<UUID> = []
    @Published var showingWinAlert = false
    
    func flipTile(_ tileID: UUID) {
        if flippedTiles.contains(tileID) {
            flippedTiles.remove(tileID)
        } else {
            flippedTiles.insert(tileID)
        }
    }
    
    
    func isFlipped(_ tileID: UUID) -> Bool {
            flippedTiles.contains(tileID)
        }
        
    func isMatched(_ tileID: UUID) -> Bool {
        matchedTiles.contains(tileID)
    }
    
    func resetGame() {
        flippedTiles.removeAll()
        matchedTiles.removeAll()
        showingWinAlert = false
    }
    
}
