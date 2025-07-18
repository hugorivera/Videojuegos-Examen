//
//  VideogamesListView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

enum Route: Hashable, Equatable {
    case videogameDetail(Videogame)
}

struct VideogamesListView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @StateObject private var gamesViewModel: VideogameViewModel
    @State private var isLoading: Bool = false
    
    init() {
        _gamesViewModel = StateObject(wrappedValue: VideogameViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            }
            List {
                ForEach(gamesViewModel.filteredGames) { videogame in
                    NavigationLink(value: Route.videogameDetail(videogame)){
                        VideogameCell(videogame: videogame)
                    }
                }
            }.listStyle(.plain)
                .searchable(text: $gamesViewModel.searchText, prompt: "Buscar videojuego")
                .navigationTitle("Videojuegos")
                .navigationBarTitleDisplayMode(.automatic)
                .onAppear {
                    withAnimation {
                        isLoading = false
                    }
                    if gamesViewModel.loadFromDB().isEmpty {
                        gamesViewModel.fetchGames()
                    }
                }
                .onReceive(gamesViewModel.$videogame) { _ in
                    withAnimation {
                        isLoading = false
                    }
                }
                .navigationDestination(for: Route.self) { destination in
                    switch destination {
                    case .videogameDetail(let videogame):
                        VideogameDetailView(game: videogame)
                    }
                }
        }
    }
}

#Preview {
    VideogamesListView()
}
