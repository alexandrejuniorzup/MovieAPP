//
//  SearchViewModel.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 26/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    private var movies = [Movie]()
    let service: ServiceProtocol
    init(service: ServiceProtocol){
        self.service = service
    }
    
    func getMoviesWithTitleService(title: String, completion: @escaping()->()) {
        service.getMovieWithTitle(title: title) { (result) in
            switch result{
            case .success(Success: let page):
                self.movies = page.results
                completion()
            case .error:
                break
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return self.movies.count
    }
    
    func cellImageAtIndexPath(indexPath: IndexPath) -> String {
        return service.getImageUrl(url: self.movies[indexPath.row].poster_path)
    }
    
    func pagination(title: String ,completion:@escaping()->()){
        service.pagination(title: title) { (result) in
            switch result{
            case .success(Success: let page):
                self.movies.append(contentsOf: page.results)
                completion()
            case .error:
                break
            }
        }
    }
    
    func returnID(indexPath:IndexPath) -> Int{
        return self.movies[indexPath.row].id!
    }
    
}
