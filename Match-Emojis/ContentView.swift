//
//  ContentView.swift
//  Match-Emojis
//
//  Created by Biraj Dahal on 2/15/25.
//

import SwiftUI

struct ContentView: View {

    @State var numTilePairs: Int = 9
    @State var curShowingTiles: [Tile] = []

    init() {
        generateTiles()
    }
    
    func generateTiles() {
        let selectedTiles = Tile.testTiles.shuffled().prefix(numTilePairs)
        curShowingTiles = (selectedTiles + selectedTiles).shuffled()
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            HStack {
                Menu("Choose Size") {
                    Button("3 pairs") { numTilePairs = 3; generateTiles() }
                    Button("6 pairs") { numTilePairs = 6; generateTiles() }
                    Button("10 pairs") { numTilePairs = 9; generateTiles() }
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
                    ForEach(curShowingTiles, id: \.emoji) { tile in
                        TileView(tile: tile)
                    }
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}


#Preview {
    ContentView()
}
