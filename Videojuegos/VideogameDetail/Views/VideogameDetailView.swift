//
//  VideogameDetailView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

struct VideogameDetailView: View {
    
    @StateObject private var detailViewModel: VideogameDetailViewModel
    @Environment(\.dismiss) var dismiss
    var game: Videogame
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isEditing: Bool = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var showDeleteAlert = false
    
    init(game: Videogame) {
        self.game = game
        _detailViewModel = StateObject(wrappedValue: VideogameDetailViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                getAsyncImage(url: game.thumbnail, maxWidth: .infinity, maxHeight: 200)
                TextField("Titulo", text: $title).textFieldStyle(RoundedBorderTextFieldStyle()).padding().disabled(!isEditing)
                TextEditor(text: $description)
                    .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1))
                    .padding().disabled(!isEditing)
                Button("Borrar videojuego", action: {
                    showDeleteAlert = true
                }).foregroundColor(.red).frame(width: 150, height: 40, alignment: .center).padding()
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if isEditing {
                        if title.isEmpty || description.isEmpty {
                            alertMessage = "Por favor, completa todos los campos antes de guardar."
                            showAlert = true
                            return
                        } else {
                            detailViewModel.updateVideogame(id: Int64(game.id), newTitle: title, newDescription: description)
                        }
                    }
                    isEditing.toggle()
                }) {
                    Image(systemName: isEditing ? "square.and.arrow.down.fill" : "pencil.circle.fill").animation(nil)
                }
            }
        }
        .onAppear {
            title = game.title
            description = game.shortDescription
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alerta"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert("Borrar videojuego?", isPresented: $showDeleteAlert) {
            Button("Borrar", role: .destructive) {
                detailViewModel.deleteVideogame(id: Int64(game.id))
                dismiss()
            }
            
            Button("Cancelar", role: .cancel) {
            }
        }
    }
}

#Preview {
    VideogameDetailView(game: Videogame.preview)
}
