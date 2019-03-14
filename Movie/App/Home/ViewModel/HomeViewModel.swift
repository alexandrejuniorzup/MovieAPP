//
//  HomeViewModel.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func didChange(url: URL)
    func presentErrorConnection()
}

class HomeViewModel {
    
    private var moviesPopular = [Movie]() {
        didSet{
            mudarDestaque()
        }
    }
    
    private var moviesRated = [Movie]()
    private var moviesUpcoming = [Movie]()
    
    var destaque:Int?
    
    
    var timer: Timer?
    weak var delegate: HomeViewModelDelegate?
    let service: ServiceProtocol
    init(service: ServiceProtocol){
        self.service = service
    }
    
    func timerDestaque(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
            self.mudarDestaque()
        })
        mudarDestaque()
    }
    
    func getPopular(completion:@escaping () -> ()) {
        service.getPopularMovies { (result) in
            switch result{
            case .success(Success: let page):
                self.moviesPopular = page.results
                completion()
            case .error(Error: let error):
                if error.localizedDescription == "The Internet connection appears to be offline."{
                    self.delegate?.presentErrorConnection()
                }
                
            }
        }
        
    }
    
    func getRated(completion:@escaping () -> ()) {
        service.getRatedMovies { (result) in
            switch result{
            case .success(Success: let page):
                self.moviesRated = page.results
                completion()
            case .error:
                break
            }
        }
        
    }
    
    func getUpcoming(completion:@escaping () -> ()) {
        service.getUpcomingMovies { (result) in
            switch result{
            case .success(Success: let page):
                self.moviesUpcoming = page.results
                completion()
            case .error:
                break
            }
        }
        
    }
    
    func numberOfMoviesInSection() -> Int {
        return self.moviesPopular.count
    }
    
    func getImage(indexPath: IndexPath,type: CollectType)-> String{
        switch type {
        case .popular:
            if let url = self.moviesPopular[indexPath.row].poster_path {
                return service.getImageUrl(url: url)
            } else {return "" }
        case .rated:
            if let url = self.moviesRated[indexPath.row].poster_path {
                return service.getImageUrl(url: url)
            } else {return "" }
        case .upcoming:
            if let url = self.moviesUpcoming[indexPath.row].poster_path {
                return service.getImageUrl(url: url)
            } else {return "" }
        }
    }
    
    func mudarDestaque(){
        guard !moviesPopular.isEmpty else {return}
        
        let movie = Int.random(in: 0...moviesPopular.count-1)
        if let url = self.moviesPopular[movie].poster_path {
            delegate?.didChange(url: URL(string: service.getImageUrl(url: url))!)
        }
        delegate?.didChange(url: URL(string: service.getImageUrl(url: self.moviesPopular[movie].poster_path!))!)
        if let aux = self.moviesPopular[movie].id {
            self.destaque = aux
        } else { mudarDestaque()}
    }
    
    func returnID(type: CollectType, indexPath: IndexPath)->Int{
        switch type {
        case .popular:
            if let id = self.moviesPopular[indexPath.row].id {
                return id
            } else { return 0}
        case .rated:
            if let id = self.moviesRated[indexPath.row].id {
                return id
            } else { return 0}
        case .upcoming:
            if let id = self.moviesRated[indexPath.row].id {
                return id
            } else { return 0}
        }
    }
    
}
