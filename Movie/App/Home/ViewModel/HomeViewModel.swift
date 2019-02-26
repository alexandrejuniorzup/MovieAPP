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
}

class HomeViewModel {
    
    private var moviesPo = [Movie]() {
        didSet{
            mudarDestaque()
        }
    }
    
    private var moviesRa = [Movie]()
    private var moviesUp = [Movie]()
    private var destaque:Int?
    
    
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
    
    func getPo(completion:@escaping () -> ()) {
        service.getPopularMovies { (result) in
            switch result{
            case .success(Success: let page):
                self.moviesPo = page.results
                completion()
            case .error:
                break
            }
        }
        
    }
    
    func getRa(completion:@escaping () -> ()) {
        service.getRatedMovies { (result) in
            switch result{
            case .success(Success: let page):
                self.moviesRa = page.results
                completion()
            case .error:
                break
            }
        }
        
    }
    
    func getUp(completion:@escaping () -> ()) {
        service.getUpcomingMovies { (result) in
            switch result{
            case .success(Success: let page):
                self.moviesUp = page.results
                completion()
            case .error:
                break
            }
        }
        
    }
    
    func numberOfMoviesInSection() -> Int {
        return self.moviesPo.count
    }
    
    func getImage(indexPath: IndexPath,type: CollectType)-> String{
        switch type {
        case .popular:
            return service.getImageUrl(url: self.moviesPo[indexPath.row].poster_path!)
        case .rated:
            return service.getImageUrl(url: self.moviesRa[indexPath.row].poster_path!)
        case .upcoming:
            return service.getImageUrl(url: self.moviesUp[indexPath.row].poster_path!)
        }
    }
    
    func mudarDestaque(){
        guard !moviesPo.isEmpty else {return}
        
        let movie = Int.random(in: 0...moviesPo.count-1)
        delegate?.didChange(url: URL(string: service.getImageUrl(url: self.moviesPo[movie].poster_path!))!)
        self.destaque = self.moviesPo[movie].id!
    }
    
}

