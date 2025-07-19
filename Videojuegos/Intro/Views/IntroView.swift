//
//  IntroView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

enum Route: Hashable, Equatable {
    case videogamesList
    case videogameDetail(Videogame)
}

struct IntroView: View {
    
    @Environment(\.managedObjectContext) private var context
    @StateObject private var introViewModel: IntroViewModel
    @State private var startList: Bool = false
    @State private var path = NavigationPath()
    
    init() {
        _introViewModel = StateObject(wrappedValue: IntroViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ProgressView()
                Text("Cargando...")
            }.onAppear {
                if introViewModel.loadFromDB().isEmpty {
                    introViewModel.fetchGames {
                        path.append(Route.videogamesList)
                    }
                } else {
                    path.append(Route.videogamesList)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .videogameDetail(let game):
                    VideogameDetailView(game: game)
                case .videogamesList:
                    VideogamesListView()
                }
            }
        }
    }
}

#Preview {
    IntroView()
}
