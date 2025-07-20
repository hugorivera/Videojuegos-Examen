//
//  IntroViewModel.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import Foundation
import Alamofire
import CoreData

class IntroViewModel: ObservableObject {
    
    @Published var videogame: [Videogame] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchGames(completion: @escaping () -> Void) {
        let url = "https://www.freetogame.com/api/games"
        AF.request(url).responseDecodable(of: [Videogame].self) { response in
            switch response.result {
            case .success(let videogame):
                DispatchQueue.main.async {
                    self.saveToDB(videogame) {
                        self.videogame = videogame
                        completion()
                    }
                }
            case .failure(let error):
                print("Error al obtener los juegos: \(error.localizedDescription)")
            }
            
        }
    }
    
    func fetchGamesAsync() async throws {
        let url = "https://www.freetogame.com/api/games"
        
        let response = await AF.request(url).serializingDecodable([Videogame].self).response
        
        switch response.result {
        case .success(let videogames):
            await MainActor.run {
                self.saveToDB(videogames) {
                    self.videogame = videogames
                }
            }
        case .failure(let error):
            throw error
        }
    }
    
    private func saveToDB(_ games: [Videogame], completion: @escaping () -> Void) {

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
            completion()
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
}
