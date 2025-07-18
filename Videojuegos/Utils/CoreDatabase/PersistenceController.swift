//
//  PersistenceController.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "VideogameModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error al cargar Core Data: \(error)")
            }
        }
    }
}
