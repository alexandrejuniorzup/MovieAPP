//
//  InfoViewModel.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 26/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

protocol InfoViewModelDelegate: class {
    func presentErrorConnection()
    func alreadyInDatabase()
    func genericError()
    func changeButton()
}

class InfoViewModel {
    
    private var id:Int?
    private var movie:Movie!
    var fromDatabase:Bool!
    var database:DataBaseProtocol
    weak var delegate: InfoViewModelDelegate?
    let service: ServiceProtocol
    init(id: Int, service: ServiceProtocol, database: DataBaseProtocol, fromDatabase:Bool){
        self.service = service
        self.id = id
        self.database = database
        self.fromDatabase = fromDatabase
    }
    
    
    func save(){
        do {
            try database.saveMovie(movie: self.movie)
            delegate?.changeButton()
        } catch DataBaseError.duplicado {
            delegate?.alreadyInDatabase()
        } catch {
            delegate?.genericError()
        }
    }
    
    func checkDatabase(){
        if !database.duplicate(id: id!){
            delegate?.alreadyInDatabase()
        }
    }
    func remove(){
        do{
            try database.removeMovie(id: self.movie.id!)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    func getMovieID(completion:@escaping()->()){
        service.getMovieWithID(id: self.id!) { (result) in
            switch result {
            case .success(Succes: let movie):
                self.movie = movie
                completion()
            case .error(Error: let error):
                if error.localizedDescription == "The Internet connection appears to be offline."{
                    self.delegate?.presentErrorConnection()
                }
            }
            
        }
    }
    
    
    func year() -> String {
        if let year = self.movie.release_date {
            var token = year.components(separatedBy: "-")
            return token[0]
        } else {
            return ""
        }
        
    }
    
    func runTime() -> String {
        if let runTime = self.movie.runtime {
            return String(runTime)
        } else {
            return ""
        }
    }
    
    func rated() -> String {
        if let rated =  self.movie.vote_average {
            return String(rated)
        } else {
            return ""
        }
    }
    
    func genre() -> String {
        var genres:String = ""
        let arr = movie.genres!
        for x in arr {
            genres = genres + " " + x.name!
        }
        return genres
    }
    
    func plot() -> String {
        if let plot = self.movie.overview {
            return plot
        } else {
            return ""
        }
    }
    
    func title() -> String {
        if let title = self.movie.title {
            return title
        } else {
            return ""
        }
    }
    
    func poster() -> String{
        if let poster = self.movie.poster_path{
            return poster
        } else {return ""}
    }
    
}
