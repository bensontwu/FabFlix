//
//  MovieDetail.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct MovieDetail: View {
    var movie: Movie
    
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
                
                Text("Directed by: \(movie.director)")
            }
            .padding()
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: MovieStore().movies[0])
    }
}
