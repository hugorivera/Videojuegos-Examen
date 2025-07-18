//
//  VideogameViewModel.swift
//  Videojuegos
//
//  Created by Hugo Rivera on 18/07/25.
//

import Foundation
import Alamofire

class VideogameViewModel: ObservableObject {
    @Published var videogame: [Videogame] = []
    
    func fetchGames() {
        let url = "https://www.freetogame.com/api/games"
        AF.request(url).responseDecodable(of: [Videogame].self) { response in
            switch response.result {
            case .success(let videogame):
                DispatchQueue.main.async {
                    self.videogame = videogame
                }
            case .failure(let error):
                print("Error al obtener los juegos: \(error.localizedDescription)")
            }
            
        }
    }
}
