//
//  View+Extensions.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import Foundation
import SwiftUI

extension View {
    
    func getAsyncImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            ZStack {
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure:
                    Image("thumb").resizable().scaledToFit()
                case .empty:
                    ProgressView()
                default:
                    EmptyView()
                }
            }.frame(width: 100, height: 50)
        }
    }
    
}
