//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Pranshu Bansal on 30/12/25.
//

import SwiftUI
import SwiftData


struct MovieList: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    
    init(titleFilter: String = ""){
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }
        _movies = Query(filter: predicate, sort: \Movie.title)
    }
    
    var body: some View {
            List {
                ForEach(movies) { movie in
                    NavigationLink(movie.title){
                        MovieDetail(movie: movie)
                    }
                }
                .onDelete(perform: deleteMovies(indexes:))
            }
            .navigationTitle("Movies")
            .toolbar {
                ToolbarItem{
                    Button("Add Movie", systemImage: "plus", action: addMovie)
                }
                ToolbarItem(placement: .topBarTrailing){
                    EditButton()
                }
            }.sheet(item: $newMovie){ movie in
                NavigationStack{
                    MovieDetail(movie: movie, isNew: true)
                }
            }.interactiveDismissDisabled(true)
    }
    
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }
}

#Preview {
    NavigationStack{
        MovieList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack{
        MovieList(titleFilter: "am")
            .modelContainer(SampleData.shared.modelContainer)
    }
}
