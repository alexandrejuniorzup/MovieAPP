import CoreData
import UIKit
import Foundation

protocol DataBaseProtocol {
    func getMovie(id:Int) throws -> MovieCore
    func getAllMovies() throws -> [MovieCore]?
    func saveMovie(movie:Movie) throws
    func removeMovie(id:Int) throws
    func duplicate(id: Int) -> Bool
}


enum DataBaseError: Error {
    case duplicado
    case failedSaveMovie
    case errorSaveImage(String)
    case notFound(String)
    case errorLoadMovies(String)
}

class Database: DataBaseProtocol {
    
    private let appDelegate: AppDelegate
    private let context: NSManagedObjectContext
    
    init(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func getMovie(id: Int) throws -> MovieCore {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieCore")
        request.predicate = NSPredicate(format: "id = %@", String(id))
        let fetchMovies = try context.fetch(request) as! [MovieCore]
        if let movie = fetchMovies.first{
            return movie
        } else {
            throw DataBaseError.notFound("Filme não encontrado")
        }
    }
    
    func getAllMovies() throws -> [MovieCore]? {
        var mov:[MovieCore]? = nil
        do {
            mov = try context.fetch(MovieCore.fetchRequest())
            return mov
        } catch {
            throw DataBaseError.errorLoadMovies("Não foi possivel carregar os filmes")
        }
    }
    
    func saveMovie(movie:Movie) throws {
        if !duplicate(id: movie.id!){
            throw DataBaseError.duplicado
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "MovieCore", in: context)
            let newMovie = NSManagedObject(entity: entity!, insertInto: context)
            newMovie.setValue(String(movie.id!), forKey: "id")
            newMovie.setValue(movie.title!, forKey: "title")
            newMovie.setValue(self.genre(genre: movie.genres!), forKey: "genre")
            newMovie.setValue(String(movie.vote_average!), forKey: "vote_average")
            newMovie.setValue(movie.overview, forKey: "overview")
            newMovie.setValue(String(movie.runtime!), forKey: "runtime")
            newMovie.setValue(String(movie.release_date!), forKey: "release_date")
            newMovie.setValue(try self.saveImage(url: movie.poster_path!), forKey: "poster_path")
            do {
                try context.save()
            } catch {
                throw DataBaseError.failedSaveMovie
            }
        }
    }
    
    func removeMovie(id: Int) throws {
        let movie = try getMovie(id: id)
        context.delete(movie as NSManagedObject)
        try context.save()
    }
    
    func saveImage(url:String) throws -> UIImage {
        let str = "https://image.tmdb.org/t/p/w400" + url
        if let data = try? Data(contentsOf: URL(string: str)!){
            return UIImage(data: data)!
        } else {
            throw DataBaseError.errorSaveImage("Não foi possivel encontrar a imagem")
        }
    }
    
    
    func genre(genre:[Genre]) -> String {
        var strGenre:String = ""
        for x in genre {
            strGenre = strGenre + " " + x.name!
        }
        return strGenre
    }
    
    func duplicate(id:Int) -> Bool {
        let request = NSFetchRequest<MovieCore>(entityName: "MovieCore")
        let predicate = NSPredicate(format: "id = %@", String(id))
        request.predicate = predicate
        do {
            let mov:[MovieCore] = try context.fetch(request)
            if mov.count != 0{
                return false
            }
        } catch {
            print(error.localizedDescription)
        }
        return true
    }
    
}
