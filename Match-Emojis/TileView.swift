//
//  TileView.swift
//  Match-Emojis
//
//  Created by Biraj Dahal on 2/15/25.
//

import SwiftUI

struct Tile: Equatable, Identifiable {
    var id = UUID()
    let emoji: String
    let matchID: Int
    
    static let testTiles: [Tile] = [
        Tile(emoji: "😂", matchID: 0),
        Tile(emoji: "😭", matchID: 1),
        Tile(emoji: "💩", matchID: 2),
        Tile(emoji: "😡", matchID: 3),
        Tile(emoji: "🥶", matchID: 4),
        Tile(emoji: "🤢", matchID: 5),
        Tile(emoji: "🍑", matchID: 6),
        Tile(emoji: "🙌🏽", matchID: 7),
        Tile(emoji: "🧐", matchID: 8),
        Tile(emoji: "🥱", matchID: 9)
    ]
}

struct TileView: View {
    let tile: Tile
    @ObservedObject var gameLogic: GameLogic
    var onTileTapped: (Tile) -> Void
    
    var body: some View {
        let isFlipped = gameLogic.isFlipped(tile.id)
        let isMatched = gameLogic.isMatched(tile.id)
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isMatched ? Color.green.gradient :
                        isFlipped ? Color.white.gradient : Color.blue.gradient)
                .border(isFlipped ? .blue : isMatched ? .green :.clear, width: 2)
            
            Text(isFlipped || isMatched ? tile.emoji : "")
                .font(.largeTitle)
            .rotation3DEffect(
                        .degrees(isFlipped || isMatched ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
        }
        .frame(width: 120, height: 150)
        .rotation3DEffect(
                    .degrees(isFlipped || isMatched ? 180 : 0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        .animation(.easeInOut(duration: 0.5), value: isFlipped)
        .animation(.easeInOut(duration: 0.5), value: isMatched)
        .onTapGesture {
            if !isMatched && !isFlipped {
                withAnimation{
                    onTileTapped(tile)
                }
            }
        }
    }
}

#Preview {
}
