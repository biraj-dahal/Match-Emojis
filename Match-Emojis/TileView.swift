//
//  TileView.swift
//  Match-Emojis
//
//  Created by Biraj Dahal on 2/15/25.
//

import SwiftUI

struct Tile : Equatable, Identifiable{
    var id = UUID()
    let emoji: String
    
    static let testTiles: [Tile] = [
        Tile(emoji: "😂"),
        Tile(emoji: "😭"),
        Tile(emoji: "💩"),
        Tile(emoji: "😡"),
        Tile(emoji: "🥶"),
        Tile(emoji: "🤢"),
        Tile(emoji: "🍑"),
        Tile(emoji: "🙌🏽"),
        Tile(emoji: "🧐")
    ]
}

struct TileView: View {
    let tile: Tile
    @State private var isFlipped = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(isFlipped ? Color.blue.gradient : Color.white.gradient)
                .border(isFlipped ? .clear : .blue, width: 2)
            
            Text(isFlipped ? "" : tile.emoji)
                .font(.largeTitle)
            
        }
        .frame(width: 120 , height: 150)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}

#Preview {
    TileView(tile: Tile(emoji: "🧐"))
}
