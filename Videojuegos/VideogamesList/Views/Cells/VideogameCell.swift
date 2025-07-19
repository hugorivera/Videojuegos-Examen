//
//  VideogameCell.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI
import Kingfisher

struct VideogameCell: View {
    let videogame: Videogame
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: videogame.thumbnail)).resizable().cancelOnDisappear(true)
                .placeholder {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 2)
                .frame(width: 100, height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(videogame.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(videogame.genre)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

#Preview {
    VideogameCell(videogame: Videogame.preview)
}
