//
//  FavoriteViewModel.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 27/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

protocol FavoriteViewModelDelegate: class {
    func reloadData()
    func alertReloadData(title:String,message:String)
}


class FavoriteViewModel {
    
    var result = [MovieCore]()    
    weak var delegate: FavoriteViewModelDelegate?
    weak var delegateCoord: FavoriteCoordinatorDelegate?
    var database:DataBaseProtocol
    init(database: DataBaseProtocol){
        self.database = database
    }
    
    func selectMovie(id: Int){
        delegateCoord?.navigateToInfo(id: id)
    }
    
    func getAll(){
        do {
            result = try database.getAllMovies()!
            delegate?.reloadData()
        } catch {
            print(error.localizedDescription)
            delegate?.alertReloadData(title: "Nao foi possivel carregar filmes", message:"")
        }
    }
    
    func numberOfRows() -> Int{
        return result.count
    }
    
    //    func image(indexPath:IndexPath) -> Data {
    //        return result[indexPath.row].poster_path as! UIImage
    //    }
    
}
