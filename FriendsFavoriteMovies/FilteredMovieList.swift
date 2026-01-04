//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Pranshu Bansal on 04/01/26.
//

import SwiftUI
import SwiftData

struct FilteredMovieList: View {
    @State var searchText: String  = ""
    
    var body: some View {
        NavigationSplitView{
            NavigationStack{
                MovieList(titleFilter: searchText)
//                    .navigationTitle("Movies")
                    .searchable(text: $searchText,placement: .navigationBarDrawer( displayMode: .always))
            }
        }detail: {
            Text("Select a Movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
