//
//  SearchViewModel.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 26/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation


protocol SearchViewModelDelegate: class {
    func responseSuccess()
    func responseError()
}

class SearchViewModel {
    
    var movies = [Movie]()
    
    weak var delegate: SearchViewModelDelegate?
    let service: ServiceProtocol
    init(service: ServiceProtocol){
        self.service = service
    }
    
    func getMoviesWithTitleService(title: String) {
        service.getMovieWithTitle(title: title) { (result) in
            switch result{
            case .success(Success: let page):
                self.movies = page.results
                self.delegate?.responseSuccess()
            case .error:
                self.delegate?.responseError()
                break
            }
        }
    }
    
    func numberOfRows() -> Int {
        return self.movies.count
    }
    
    func cellImageAtIndexPath(indexPath: IndexPath) -> String {
        return service.getImageUrl(url: self.movies[indexPath.row].poster_path)
    }
    
    func pagination(title: String){
        service.pagination(title: title) { (result) in
            switch result{
            case .success(Success: let page):
                self.delegate?.responseSuccess()
                self.movies.append(contentsOf: page.results)
            case .error:
                break
            }
        }
    }
    
    func returnID(indexPath:IndexPath) -> Int{
        return self.movies[indexPath.row].id!
    }
    
    func cleanMovies(){
        self.movies = []
    }
}
