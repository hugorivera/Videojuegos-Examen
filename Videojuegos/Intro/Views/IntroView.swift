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
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    init() {
        _introViewModel = StateObject(wrappedValue: IntroViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ProgressView()
                Text("Cargando...")
            }.onAppear {
                Task {
                    await loadOrRetry()
                }
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("Reintentar", role: .cancel) {
                    Task {
                        await loadOrRetry()
                    }
                }
            } message: {
                Text(errorMessage)
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
    
    func loadOrRetry() async {
        do {
            if introViewModel.loadFromDB().isEmpty {
                try await introViewModel.fetchGamesAsync()
            }
            path.append(Route.videogamesList)
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }

}

#Preview {
    IntroView()
}
