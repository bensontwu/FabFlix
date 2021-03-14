//
//  MovieList.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct MovieList: View {
    @EnvironmentObject var movieStore: MovieStore
    @EnvironmentObject var sessionStore: SessionStore
    
    var body: some View {
        NavigationView {
            List(movieStore.movies) { movie in
                NavigationLink(destination: MovieDetail(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
            .navigationTitle("Movies")
        }
    }
    
    func refreshMovies() {
        // TODO: update params!
        movieStore.refreshMovies(params: ["title": "batman"])
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
