//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Pranshu Bansal on 30/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var searchableText: String = ""
    
    var body: some View {
        TabView{
            Tab("Friends", systemImage: "person.and.person") {
                FriendList()
            }
            Tab("Movies", systemImage: "film.stack") {
                FilteredMovieList()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
