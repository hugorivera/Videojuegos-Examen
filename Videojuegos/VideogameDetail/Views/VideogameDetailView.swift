//
//  VideogameDetailView.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

struct VideogameDetailView: View {
    var game: Videogame
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isEditing: Bool = false
    
    
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
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
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
    }
}

#Preview {
    VideogameDetailView(game: Videogame.preview)
}
