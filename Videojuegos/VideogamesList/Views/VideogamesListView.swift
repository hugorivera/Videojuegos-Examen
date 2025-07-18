//
//  VideogamesListView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

struct VideogamesListView: View {
    
    let videogames: [Videogame] = [
        Videogame(id: "1", name: "Videojuego 1", image: "thumb"),
        Videogame(id: "2", name: "Videojuego 2", image: "thumb"),
        Videogame(id: "3", name: "Videojuego 3", image: "thumb"),
        Videogame(id: "4", name: "Videojuego 4", image: "thumb")
    ]
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            }
            List {
                ForEach(videogames) { videogame in
                    VideogameCell(videogame: videogame)
                }
            }.listStyle(.plain)
                .navigationTitle("Videojuegos")
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    VideogamesListView()
}
