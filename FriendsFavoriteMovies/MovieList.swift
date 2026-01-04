//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Pranshu Bansal on 30/12/25.
//

import SwiftUI
import SwiftData


struct MovieList: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    var body: some View {
        NavigationSplitView{
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
        }detail: {
            Text("Select a Movie")
                .navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.inline)
        }
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
    MovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
