//
//  MovieRow.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct MovieRow: View {
    var movie: Movie
    
    var body: some View {
        HStack {
            movie.posterImage
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(movie.title)
            
            Spacer()
            
            Text(String(movie.rating))
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static let sessionStore = SessionStore()
    
    static var previews: some View {
        Group {
            MovieRow(movie: MovieStore(sessionStore: sessionStore).movies[0])
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
    
}
