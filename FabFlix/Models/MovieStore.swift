//
//  MovieStore.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import Foundation

final class MovieStore: ObservableObject {
    @Published var movies: [Movie] = loadMovies(jsonData: loadJsonArray("movie-search.json"))
    
    private static func loadMovies(jsonData: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for movieJson in jsonData {
            if let movie = Movie(json: movieJson) {
                movies.append(movie)
            } else {
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
