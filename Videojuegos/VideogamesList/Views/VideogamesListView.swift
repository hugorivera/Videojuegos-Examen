//
//  VideogamesListView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

struct VideogamesListView: View {
    
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
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "person.crop.circle").resizable().frame(width: 40, height: 40).foregroundColor(.blue)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hola 👋")
                            .font(.headline)
                        Text("Tienes \(gamesViewModel.filteredGames.filter { !($0.isVideogameDeleted ?? false) }.count) videojuegos disponibles")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                List {
                    ForEach(gamesViewModel.filteredGames) { videogame in
                        if !(videogame.isVideogameDeleted ?? false) {
                            NavigationLink(value: Route.videogameDetail(videogame)){
                                VideogameCell(videogame: videogame)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
                .searchable(text: $gamesViewModel.searchText, prompt: "Buscar videojuego")
                .navigationTitle("Videojuegos")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarBackButtonHidden()
                .onAppear {
                    withAnimation {
                        isLoading = true
                    }
                    _ = gamesViewModel.loadFromDB()
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
