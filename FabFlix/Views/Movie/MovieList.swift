//
//  MovieList.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct MovieList: View {
    @ObservedObject var movieStore: MovieStore = MovieStore()
    
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
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
