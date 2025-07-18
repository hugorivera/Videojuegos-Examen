//
//  VideogamesListView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

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
                    if gamesViewModel.loadFromDB().isEmpty {
                        gamesViewModel.fetchGames()
                    }
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
