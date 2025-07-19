//
//  View+Extensions.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import Foundation
import SwiftUI

extension View {
    
    func getAsyncImage(url: String, maxWidth: CGFloat, maxHeight: CGFloat) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            ZStack {
                switch phase {
                case .success(let image):
                    image.resizable()
                case .failure:
                    Image("thumb").resizable()
                case .empty:
                    ProgressView()
                default:
                    EmptyView()
                }
            }.frame(maxWidth: maxWidth, minHeight: maxHeight, maxHeight: maxHeight)
        }
    }
    
}
