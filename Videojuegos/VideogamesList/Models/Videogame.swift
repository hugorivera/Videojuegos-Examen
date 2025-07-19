//
//  Videogames.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import Foundation

struct Videogame: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileURL: String
    let isVideogameDeleted: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case shortDescription = "short_description"
        case gameURL = "game_url"
        case genre
        case platform
        case publisher
        case developer
        case releaseDate = "release_date"
        case freetogameProfileURL = "freetogame_profile_url"
        case isVideogameDeleted
    }
}

