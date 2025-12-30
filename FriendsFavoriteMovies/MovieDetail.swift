//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Pranshu Bansal on 31/12/25.
//

import SwiftUI
import SwiftData

struct MovieDetail: View {
    @Bindable var movie: Movie
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            TextField("Movie title", text: $movie.title)
            DatePicker("Release Date", selection: $movie.releaseDate, displayedComponents: .date)
        }
        .navigationTitle("Movies")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction){
                Button("Save"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    context.delete(movie)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie)
    }
}
