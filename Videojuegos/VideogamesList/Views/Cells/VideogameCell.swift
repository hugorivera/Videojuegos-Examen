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
            Text(videogame.title)
            Spacer()
        }
    }
}

#Preview {
    //VideogameCell(videogame: Videogame(id: "1", name: "Nombre", image: "thumb"))
}
