//
//  Service.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation


protocol ServiceProtocol {
    
    func getMovieWithID(id:Int, completion:@escaping(Response<Movie>) -> ())
    func getMovieWithTitle(title:String, completion:@escaping(Response<Page>) -> ())
    func pagination(title:String, completion:@escaping(Response<Page>) -> ())
    func getPopularMovies(completion:@escaping(Response<Page>) -> ())
    func getRatedMovies(completion:@escaping(Response<Page>) -> ())
    func getUpcomingMovies(completion:@escaping(Response<Page>) -> ())
    func getImageUrl(url:String?) -> String
    
}

class Service: ServiceProtocol {
    
    private let apiKey: String = "423a7efcc5851107f96bc25a3b0c3f28"
    private let language: String = "&language=pt-BR"
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let basePoster: String = "https://image.tmdb.org/t/p/w400"
    private var pagCount = 2
    
    private func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data,response,error)
        }
        task.resume()
    }
    
    private func parseData<T:Codable>(url:URL, completion:@escaping(Response<T>) -> ()) {
        getData(url: url) { (data, response, error) in
            do{
                let decoder = JSONDecoder()
                let movie = try decoder.decode(T.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(.success(movie))
                }
            } catch let parsingError{
                DispatchQueue.main.async {
                    completion(.error(parsingError))
                }
            }
        }
    }
    
    func getMovieWithID(id: Int, completion: @escaping (Response<Movie>) -> ()) {
        let url = URL(string: baseURL + "/movie/" + "\(id)?api_key=" + apiKey + language)
        parseData(url: url!) { (result:Response<Movie>) in
            completion(result)
        }
    }
    
    func getMovieWithTitle(title: String, completion: @escaping (Response<Page>)->()) {
        self.pagCount = 2
        let replace = title.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: baseURL + "/search/movie?api_key=" + apiKey + "&query=" + replace + language)
        parseData(url: url!) { (result:Response<Page>) in
            completion(result)
        }
    }
    
    func pagination(title: String, completion: @escaping (Response<Page>) -> ()) {
        let replace = title.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: baseURL + "/search/movie?api_key=" + apiKey + "&query=" + replace + language + "&page=" + String(pagCount))
        self.pagCount+=1
        parseData(url: url!) { (result:Response<Page>) in
            completion(result)
        }
    }
    
    func getPopularMovies(completion:@escaping(Response<Page>) -> ()) {
        let url = URL(string: baseURL + "/movie/popular?api_key=" + apiKey + language)
        parseData(url: url!) { (result:Response<Page>) in
            completion(result)
        }
    }
    
    func getRatedMovies(completion:@escaping(Response<Page>) -> ()) {
        let url = URL(string: baseURL + "/movie/top_rated?api_key=" + apiKey + language)
        parseData(url: url!) { (result:Response<Page>) in
            completion(result)
        }
    }
    
    func getUpcomingMovies(completion:@escaping(Response<Page>) -> ()) {
        let url = URL(string: baseURL + "/movie/upcoming?api_key=" + apiKey + language)
        parseData(url: url!) { (result:Response<Page>) in
            completion(result)
        }
    }
    
    func getImageUrl(url:String?) -> String {
        if let url = url {
            return basePoster + url
        } else {return ""}
    }
}
