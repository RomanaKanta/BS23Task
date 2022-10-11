//
//  HomeView.swift
//  BS23Task
//
//  Created by Romana on 11/10/22.
//

import SwiftUI

struct HomeView: View {
    var serviceConsumer = ServiceConsumer()
    @State  var movies: [MovieResult] = []
    @State private var searchText = ""
    var filteredResorts: [MovieResult] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var body: some View {
            NavigationView {
                List{
                    ForEach(self.filteredResorts) { movie in
                        HStack(spacing: 10){
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 160, alignment: .center)
                            } placeholder: {
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 160, alignment: .center)
                                    .background(.gray)
                                
                            }
                            VStack(alignment: .leading, spacing: 10){
                                Text(movie.title).bold()
                                Text(movie.overview)
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .onAppear(){
                    serviceConsumer.loadData { movies in
                        self.movies = movies.results
                    }
                }
                .navigationTitle("Movie List")
                .searchable(text: $searchText, prompt: "Search for a movie")
            }
    }

    }
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
