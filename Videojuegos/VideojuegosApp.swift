//
//  VideojuegosApp.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import SwiftUI

@main
struct VideojuegosApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            IntroView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
