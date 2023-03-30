//
//  MovieHeader.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct MovieHeader: View {
    let movie: Movie

    @Environment(\.deviceStatus) private var deviceStatus
    @Environment(\.inWishlist) private var inWishlist
    @Environment(\.updateWishlist) private var updateWishlist
    @State private var readyToUpdateMovieID: Int?

    private var compact: Bool {
        deviceStatus == .compact
    }

    private var lineLimit: Int {
        compact ? 4 : 8
    }

    private var isFavorite: Bool {
        inWishlist(movie.id)
    }

    init(movie: Movie) {
        self.movie = movie
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            title
            posterAndDescription
        }
        .padding(16)
        .background(Assets.Colors.rowBackground)
    }

    var title: some View {
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
        #if os(macOS)
        .padding(.top,20)
        #endif
    }

    var overview: some View {
        Text(movie.overview ?? "")
            .lineLimit(lineLimit)
            .font(.footnote)
            .foregroundColor(.secondary)
    }

    var favoriteButton: some View {
        Button {
            if isFavorite {
                readyToUpdateMovieID = movie.id
            } else {
                updateWishlist(movie.id)
            }

        } label: {
            HStack(spacing: compact ? 10 : 20) {
                Image(systemName: isFavorite ? "checkmark" : "plus")
                Text(isFavorite ? "Favorite_Button_Cancel" : "Favorite_Button_Add")
            }
            .foregroundColor(!isFavorite ? .black : .primary)
            .padding(.vertical, 10)
            .padding(.leading, compact ? 10 : 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(isFavorite ? .clear : Assets.Colors.favorite)
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Assets.Colors.outline, lineWidth: 1)
                }
            )
        }
        .buttonStyle(.plain)
    }

    var posterAndDescription: some View {
        HStack(alignment: .top, spacing: 20) {
            ItemPoster(movie: movie, size: DisplayType.portrait(.small).imageSize, enableScale: false)
            VStack(alignment: .leading, spacing: 10) {
                GenreList(genres: movie.genres)
                overview
                Spacer()
                RateView(rate: movie.voteAverage, participants: movie.voteCount)
                favoriteButton
            }
        }
        .frame(height: DisplayType.portrait(.small).imageSize.height)
        .animation(.default, value: isFavorite)
        .confirmationDialog("Wishlist_Manage", isPresented: .isPresented($readyToUpdateMovieID), presenting: readyToUpdateMovieID) { movieID in
            Button("Confirm_To_Remove_From_Favorite_Movies", role: .destructive) {
                updateWishlist(movieID)
            }
        }
    }
}

struct MovieHeader_Previews: PreviewProvider {
    static var previews: some View {
        MovieHeader(movie: .previewMovie1)
    }
}
