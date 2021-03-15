//
//  Movie.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import Foundation
import SwiftUI

class Movie: Identifiable {
    
    var id: String
    var title: String
    var year: Int
    var director: String
    var rating: Double
    var backdropPath: String
    var posterPath: String
    
    var posterImage: Image {
        Image(systemName: "star")
    }
    
    init?(json: [String: Any]) {
        guard let id = json["movie_id"] as? String,
              let title = json["title"] as? String,
              let year = json["year"] as? Int,
              let director = json["director"] as? String,
              let rating = json["rating"] as? Double,
              let backdropPath = json["backdrop_path"] as? String,
              let posterPath = json["poster_path"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.title = title
        self.year = year
        self.director = director
        self.rating = rating
        self.backdropPath = backdropPath
        self.posterPath = posterPath
    }
}

class DetailedMovie: Movie {
    
    var genres: [Genre]
    var people: [Person]
    
    override init?(json: [String: Any]) {
        guard let genresJsonArr = json["genres"] as? [[String: Any]],
              let genres = Genre.getGenres(jsonArray: genresJsonArr),
              let peopleJsonArr = json["people"] as? [[String: Any]],
              let people = Person.getPeople(jsonArray: peopleJsonArr)
        else {
            return nil
        }
        
        self.genres = genres
        self.people = people
        
        super.init(json: json)
    }
}

struct Person: Identifiable {
    var id: Int
    var name: String
    
    init?(json: [String: Any]) {
        guard let id = json["person_id"] as? Int,
              let name = json["name"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
    
    static func getPeople(jsonArray: [[String: Any]]) -> [Person]? {
        var people: [Person] = []
        for jsonObj in jsonArray {
            if let person = Person(json: jsonObj) {
                people.append(person)
            }
        }
        if people.count == 0 { return nil }
        return people
    }
}

struct Genre: Identifiable {
    var id: Int
    var name: String
    
    init?(json: [String: Any]) {
        guard let id = json["genre_id"] as? Int,
              let name = json["name"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
    
    static func getGenres(jsonArray: [[String: Any]]) -> [Genre]? {
        var genres: [Genre] = []
        for jsonObj in jsonArray {
            if let genre = Genre(json: jsonObj) {
                genres.append(genre)
            }
        }
        if genres.count == 0 { return nil }
        return genres
    }
}
