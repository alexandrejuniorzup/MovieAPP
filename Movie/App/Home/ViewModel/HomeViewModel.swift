//
//  HomeViewModel.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private var moviesPo = [Movie]() {
        didSet{
            mudarDestaque()
        }
    }
    
    let service: ServiceProtocol
    
    init(service: ServiceProtocol){
        self.service = service
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
    
    func numberOfMoviesInSection() -> Int {
        return self.moviesPo.count
    }
    
    func getImage(indexPath: IndexPath)-> String{
        return service.getImageUrl(url: self.moviesPo[indexPath.row].poster_path!)
    }
    
    func mudarDestaque(){
    }
    
}

