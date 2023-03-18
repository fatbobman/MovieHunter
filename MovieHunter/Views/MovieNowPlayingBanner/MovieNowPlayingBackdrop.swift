//
//  MovieNowPlayingBackDrop.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import Nuke
import NukeUI
import SwiftUI
import TMDb

struct MovieNowPlayingBackdrop: View {
    let movie: Movie
    @Environment(\.imagePipeline) var imagePipeline

    var backdropPath: URL? {
        guard let path = movie.backdropPath else { return nil }
        return moviePosterURLPrefix
            .appending(path: "/w500")
            .appending(path: path.absoluteString)
    }

    var body: some View {
        LazyImage(url: backdropPath) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Assets.Colors.imagePlaceHolder)
            }
        }
        .pipeline(imagePipeline)
        .clipped()
        .overlay(
            VStack {
                // Fake Button
                ZStack {
                    Circle()
                        .fill(.secondary)
                    Circle()
                        .stroke(Assets.Colors.secondWhite, lineWidth: 3)
                    Image(systemName: "play.fill")
                        .font(.title)
                        .foregroundColor(Assets.Colors.secondWhite)
                }
                .frame(width: 52, height: 52)
//                }
            }
        )
    }
}

#if DEBUG
    struct MovieNowPlayingBackdrop_Previews: PreviewProvider {
        static var previews: some View {
            MovieNowPlayingBackdrop(
                movie: PreviewData.previewMovie
            )
            .frame(width: 400, height: 400 / 1.77)
        }
    }
#endif
