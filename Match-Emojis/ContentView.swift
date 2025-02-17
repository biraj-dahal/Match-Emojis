//
//  ContentView.swift
//  Match-Emojis
//
//  Created by Biraj Dahal on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    @State var numTilePairs: Int = 3
    @State var curShowingTiles: [Tile] = []
    @StateObject private var gameLogic = GameLogic()
    
    func generateTiles() {
        let selectedTiles = Tile.testTiles.prefix(upTo: numTilePairs)

        curShowingTiles = (selectedTiles.map { tile in
            Tile(id: UUID(), emoji: tile.emoji, matchID: tile.matchID)
        } + selectedTiles.map { tile in
            Tile(id: UUID(), emoji: tile.emoji, matchID: tile.matchID)
        }).shuffled()
        gameLogic.resetGame()
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    func checkWinCondition() {
            if gameLogic.matchedTiles.count == curShowingTiles.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    gameLogic.showingWinAlert = true
                }
            }
        }
    
    func handleTileTapped(_ tappedTile: Tile) {
        if gameLogic.flippedTiles.count >= 2 { return }
        
        gameLogic.flipTile(tappedTile.id)
        
        if gameLogic.flippedTiles.count == 2{
            let flippedTilesIds = Array(gameLogic.flippedTiles)
            let firstTile = curShowingTiles.first(where: { $0.id == flippedTilesIds[0] })!
            let secondTile = curShowingTiles.first(where: { $0.id == flippedTilesIds[1] })!
            if firstTile.matchID == secondTile.matchID {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    gameLogic.matchedTiles.insert(firstTile.id)
                    gameLogic.matchedTiles.insert(secondTile.id)
                    gameLogic.flippedTiles.removeAll()
                    checkWinCondition()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    gameLogic.flippedTiles.removeAll()
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Menu("Choose Size") {
                    Button("3 pairs") { numTilePairs = 3; generateTiles() }
                    Button("6 pairs") { numTilePairs = 6; generateTiles() }
                    Button("10 pairs") { numTilePairs = 10; generateTiles() }
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                Spacer()
                
                Button("Reset") {
                    generateTiles()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
            .bold()
            .foregroundStyle(.white)
            .padding()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(curShowingTiles) { tile in
                        TileView(tile: tile, gameLogic: gameLogic, onTileTapped: handleTileTapped)
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onAppear { generateTiles() }
        .alert("Congratulations!", isPresented: $gameLogic.showingWinAlert) {
                    Button("Play Again", action: generateTiles)
                } message: {
                    Text("You are the god of this game!")
                }
    }
}

#Preview {
    ContentView()
}
