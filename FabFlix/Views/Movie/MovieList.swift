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
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    RoundedTextField(placeholderText: "Search", textBinding: $searchText)
                    
                    HStack {
                        FilterButton(title: "Filers") {
                            // do something
                        }
                        FilterButton(title: "Sort") {
                            //do something
                        }
                        FilterButton(title: "Limit") {
                            // do something
                        }
                        FilterButton(title: "Offset") {
                            // do something
                        }
                    }
                }
                
                ForEach(movieStore.movies) { movie in
                    NavigationLink(destination: MovieDetail(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
            }
            .navigationTitle("Movies")
            .toolbar {
                Button("Sign Out") {
                    sessionStore.reset()
                }
            }

        }
    }
    
    func refreshMovies() {
        // TODO: update params!
        movieStore.refreshMovies(params: ["title": "batman"])
    }
}

struct MovieList_Previews: PreviewProvider {
    static let sessionStore = SessionStore()
    
    static var previews: some View {
        MovieList()
            .environmentObject(MovieStore(sessionStore: sessionStore))
            .environmentObject(sessionStore)
    }
}
