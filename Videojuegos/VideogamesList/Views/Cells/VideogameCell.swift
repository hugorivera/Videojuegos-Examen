//
//  VideogameCell.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

struct VideogameCell: View {
    let videogame: Videogame
    var body: some View {
        HStack(spacing: 20) {
            getAsyncImage(url: videogame.thumbnail).padding()
            VStack(spacing: 10) {
                Text(videogame.title).font(.headline).multilineTextAlignment(.center).frame(maxWidth: .infinity)
                Text(videogame.genre).font(.caption).multilineTextAlignment(.center).frame(maxWidth: .infinity)
            }
            Spacer()
        }
    }
}

#Preview {
    VideogameCell(videogame: Videogame.preview)
}
