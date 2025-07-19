//
//  VideogameViewModel.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import Foundation
import Alamofire
import CoreData

class VideogameViewModel: ObservableObject {
    @Published var videogame: [Videogame] = []
    @Published var searchText: String = ""
    
    private let context: NSManagedObjectContext
    
    var filteredGames: [Videogame] {
        if searchText.isEmpty {
            return videogame
        } else {
            return videogame.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.genre.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchGames() {
        let url = "https://www.freetogame.com/api/games"
        AF.request(url).responseDecodable(of: [Videogame].self) { response in
            switch response.result {
            case .success(let videogame):
                DispatchQueue.main.async {
                    self.videogame = videogame
                    self.saveToDB(videogame)
                }
            case .failure(let error):
                print("Error al obtener los juegos: \(error.localizedDescription)")
            }
            
        }
    }
    
    private func saveToDB(_ games: [Videogame]) {
        //deleteAllGames() // Evitar duplicados

        for game in games {
            let entity = VideogameEntity(context: context)
            entity.id = Int64(game.id)
            entity.title = game.title
            entity.thumbnail = game.thumbnail
            entity.shortdescription = game.shortDescription
            entity.gameURL = game.gameURL
            entity.genre = game.genre
            entity.platform = game.platform
            entity.publisher = game.publisher
            entity.developer = game.developer
            entity.releaseDate = game.releaseDate
            entity.freetogameProfileURL = game.freetogameProfileURL
            entity.isVideogameDeleted = false
        }

        do {
            try context.save()
        } catch {
            print("Error al guardar en Core Data: \(error)")
        }
    }
    
    func loadFromDB() -> [Videogame] {
        let request: NSFetchRequest<VideogameEntity> = VideogameEntity.fetchRequest()
        do {
            let savedGames = try context.fetch(request)
            self.videogame = savedGames.map {
                Videogame(
                    id: Int($0.id),
                    title: $0.title ?? "",
                    thumbnail: $0.thumbnail ?? "",
                    shortDescription: $0.shortdescription ?? "",
                    gameURL: $0.gameURL ?? "",
                    genre: $0.genre ?? "",
                    platform: $0.platform ?? "",
                    publisher: $0.publisher ?? "",
                    developer: $0.developer ?? "",
                    releaseDate: $0.releaseDate ?? "",
                    freetogameProfileURL: $0.freetogameProfileURL ?? "",
                    isVideogameDeleted: $0.isVideogameDeleted
                )
            }
            return self.videogame
        } catch {
            print("Error al leer de Core Data: \(error)")
            return []
        }
    }
    
    private func deleteAllGames() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = VideogameEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error al eliminar datos previos: \(error)")
        }
    }
}
