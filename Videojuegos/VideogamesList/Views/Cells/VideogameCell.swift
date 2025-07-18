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
            Image("thumb").resizable().frame(width: 100, height: 50).scaledToFit().padding()
            Text("Nombre del videojuego")
            Spacer()
        }
    }
}

#Preview {
    VideogameCell(videogame: Videogame(id: "1", name: "Nombre", image: "thumb"))
}
