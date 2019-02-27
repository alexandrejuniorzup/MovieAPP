//
//  FavoriteViewModel.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 27/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation


class FavoriteViewModel {
    
    var result = [MovieCore]() {
        didSet{

        }
    }
    var database:DataBaseProtocol
    
    init(database: DataBaseProtocol){
        self.database = database
    }
    
    
    func getAll(completion:@escaping()->()){
        do {
            result = try database.getAllMovies()!
            completion()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func numberOfRows() -> Int{
        return result.count
    }
    
//    func image(indexPath:IndexPath) -> Data {
//        return result[indexPath.row].poster_path as! UIImage
//    }

}
