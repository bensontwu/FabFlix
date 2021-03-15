//
//  MovieList.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

enum OrderBy: String, CaseIterable, Identifiable {
    case title
    case rating
    case year
    
    var id: String { self.rawValue }
}

enum Direction: String, CaseIterable, Identifiable {
    case asc
    case desc
    
    var id: String { self.rawValue }
}

struct MovieList: View {
    @EnvironmentObject var movieStore: MovieStore
    @EnvironmentObject var sessionStore: SessionStore
    @State var searchText: String = ""
    
    @State var title: String = ""
    @State var director: String = ""
    @State var genre: String = ""
    @State var year: String = ""
    
    @State var orderBy: OrderBy = OrderBy.title
    @State var direction: Direction = Direction.asc
    
    @State var filterOffset : CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    HStack {
                        RoundedTextField(placeholderText: "Search", textBinding: $searchText)

                        FilterButton(title: "Filters") {
                            self.filterOffset = 0
                        }
                    }
                    
                    ForEach(movieStore.movies) { movie in
                        NavigationLink(destination: MovieDetail(movie: movie).environmentObject(movieStore)) {
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
                
                VStack{
                    
                    Spacer()
                    
                    SearchPanel(title: $title, director: $director, genre: $genre, year: $year, orderBy: $orderBy, direction: $direction) {
                        refreshMovies()
                    }
                        .offset(y: self.filterOffset)
                        .gesture(DragGesture().onChanged({ (value) in
                            if value.translation.height > 0 {
                                self.filterOffset = value.location.y
                            }
                        })
                        .onEnded({ (value) in
                            if self.filterOffset > 100 {
                                self.filterOffset = UIScreen.main.bounds.height
                            } else {
                                self.filterOffset = 0
                            }
                        })
                    )
                }.background((self.filterOffset <= 100 ? Color(UIColor.label).opacity(0.3) : Color.clear).edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                    self.filterOffset = 0
                })
                .edgesIgnoringSafeArea(.bottom)
            }
            .animation(.default)
        }
    }
    
    private func getParams() -> [String: String] {
        var params: [String: String] = [:]
        if title != "" {
            params["title"] = title
        }
        if director != "" {
            params["director"] = director
        }
        if genre != "" {
            params["genre"] = genre
        }
        if year != "" {
            params["year"] = year
        }
        params["direction"] = direction.rawValue
        params["orderby"] = orderBy.rawValue
        return params
    }
    
    private func refreshMovies() {
        movieStore.refreshMovies(params: getParams())
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
