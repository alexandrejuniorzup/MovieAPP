//
//  Movie.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

struct Genre : Codable{
    var id: Int?
    var name: String?
    
    init() {
        id = 0
        name = "Genero"
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

struct Movie : Codable{
    var genres: [Genre]?
    var id: Int?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var release_date: String?
    var runtime: Int?
    var title: String?
    var vote_average: Float?
    var vote_count: Int?
    var favorite: Bool?
}
