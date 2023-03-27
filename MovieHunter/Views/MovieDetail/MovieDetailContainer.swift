//
//  MovieDetailContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct MovieDetailContainer: View {
    @State private var movie: Movie?
    private let movieID: Int
    init(movie: Movie) {
        movieID = movie.id
    }

    @Environment(\.tmdb) private var tmdb
    var body: some View {
        VStack(alignment: .leading) {
            if let movie {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(movie.title)
                                .font(.title)
                            if let releaseDate = movie.releaseDate {
                                Text(releaseDate, format: .dateTime.year().month())
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.bottom, 10)

                        HStack(alignment: .top, spacing: 20) {
                            ItemPoster(movie: movie, size: DisplayType.portrait(.small).imageSize)
                            VStack(alignment: .leading, spacing: 10) {
                                GenreList(movie: movie)

                                Text(movie.overview ?? "")
                                    .lineLimit(8)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: 600)
                .border(.blue)
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            if let movie = try? await tmdb.movies.details(forMovie: movieID) {
                self.movie = movie
            }
        }
    }
}

struct GenreList: View {
    let movie: Movie
    @Environment(\.tmdb) private var tmdb
    var body: some View {
        ViewThatFits(in: .horizontal) {
            genres
            ScrollView(.horizontal, showsIndicators: false) {
                genres
            }
        }
    }

    var genres: some View {
        HStack {
            ForEach(movie.genres ?? []) { genre in
                Text(genre.name)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.secondary)
                    )
            }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

#if DEBUG
    struct MovieDetailContainer_Previews: PreviewProvider {
        static var previews: some View {
            MovieDetailContainer(movie: PreviewData.previewMovie1)
        }
    }
#endif
