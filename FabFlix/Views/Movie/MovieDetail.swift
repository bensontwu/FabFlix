//
//  MovieDetail.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct MovieDetail: View {
    
    var movie: Movie
    @State var detailedMovie: DetailedMovie?
    @EnvironmentObject var movieStore: MovieStore
    
    var body: some View {
        ScrollView {
            movie.posterImage
                .resizable()
                .frame(width: 150, height: 150)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title)
                
                HStack {
                    Text(String(movie.year))
                    Spacer()
                    Text(String(movie.rating))
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                HStack {
                    Text("Directed by: \(movie.director)")
                    
                    Spacer()
                    
                    if let detailedMovie = detailedMovie {
                        Text("Votes: \(detailedMovie.numVotes)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                
                if let detailedMovie = detailedMovie {
                    
                    Text("Overview")
                        .font(.title2)
                    Text(detailedMovie.overview)
                    
                    Divider()
                    
                    Text("Genres")
                        .font(.title2)
                    
                    ForEach(detailedMovie.genres) { genre in
                        Text(genre.name)
                    }
                    
                    Divider()
                    
                    Group {
                        Text("People")
                            .font(.title2)
                        
                        ForEach(detailedMovie.people) { person in
                            Text(person.name)
                        }
                    }
                    
                    Divider()
                }
            }
            .padding()
        }
        .onAppear() {
            fetchMovie()
        }
    }
    
    private func fetchMovie() {
        movieStore.getMovie(movieId: movie.id) { detailedMovie in
            if let detailedMovie = detailedMovie {
                self.detailedMovie = detailedMovie
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static let sessionStore = SessionStore()
    
    static var previews: some View {
        MovieDetail(movie: MovieStore(sessionStore: sessionStore).movies[0])
    }
}
