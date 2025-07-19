//
//  VideogameDetalViewModel.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import Foundation
import CoreData

class VideogameDetailViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func updateVideogame(id: Int64, newTitle: String, newDescription: String) {
        let fetchRequest: NSFetchRequest<VideogameEntity> = VideogameEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.fetchLimit = 1
        
        do {
            if let videogame = try context.fetch(fetchRequest).first {
                videogame.title = newTitle
                videogame.shortdescription = newDescription
                try context.save()
            } else {
                print("No se encontró el videojuego con ese ID")
            }
        } catch {
            print("Error al actualizar el videojuego: \(error)")
        }
    }
    
    func deleteVideogame(id: Int64) {
        let fetchRequest: NSFetchRequest<VideogameEntity> = VideogameEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.fetchLimit = 1
        
        do {
            if let videogame = try context.fetch(fetchRequest).first {
                videogame.isVideogameDeleted = true
                try context.save()
            } else {
                print("No se encontró el videojuego con ese ID")
            }
        } catch {
            print("Error al actualizar el videojuego: \(error)")
        }
    }
    
}
