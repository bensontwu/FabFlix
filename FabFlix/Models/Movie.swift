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
