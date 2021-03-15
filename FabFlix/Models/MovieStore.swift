//
//  MovieStore.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import Foundation

final class MovieStore: ObservableObject {
    
    @Published var movies: [Movie] = []
    var sessionStore: SessionStore
    
    private final let movieClient = MovieClient()
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        refreshMovies(params: [:])
    }
    
    public func refreshMovies(params: [String: Any]) {
        movieClient.search(sessionData: sessionStore.sessionData, params: params) { jsonArray in
            self.movies = MovieStore.loadMovies(jsonArray: jsonArray)
        }
    }
    
    public func getMovie(movieId: String, handler: @escaping (DetailedMovie?) -> ()) {
        movieClient.get(sessionData: sessionStore.sessionData, movieId: movieId) { jsonObj in
            handler(DetailedMovie(json: jsonObj))
        }
    }
    
    private static func loadMovies(jsonArray: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for movieJson in jsonArray {
            if let movie = Movie(json: movieJson) {
                movies.append(movie)
            }
        }
        return movies
    }
}

func loadJsonArray(_ filename: String) -> [[String: Any]] {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let jsonResult = try JSONSerialization.jsonObject(with: data)
        if let jsonResult = jsonResult as? [[String: Any]] {
            return jsonResult
        } else {
            fatalError("Couldn't parse \(filename) into JSON array")
        }
    } catch {
        fatalError("Couldn't parse \(filename) as JSON")
    }
}
