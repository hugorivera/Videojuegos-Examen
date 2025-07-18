//
//  VideogamesListView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

struct VideogamesListView: View {
    
    @StateObject private var gamesViewModel = VideogameViewModel()
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            }
            List {
                ForEach(gamesViewModel.videogame) { videogame in
                    VideogameCell(videogame: videogame)
                }
            }.listStyle(.plain)
                .navigationTitle("Videojuegos")
                .navigationBarTitleDisplayMode(.automatic)
                .onAppear {
                    withAnimation {
                        isLoading = false
                    }
                    gamesViewModel.fetchGames()
                }
                .onReceive(gamesViewModel.$videogame) { _ in
                    withAnimation {
                        isLoading = false
                    }
                }
        }
    }
}

#Preview {
    VideogamesListView()
}
