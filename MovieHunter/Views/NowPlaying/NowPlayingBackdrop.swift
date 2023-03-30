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

struct NowPlayingBackdrop: View {
    let movie: Movie
    private let showPlayButton: Bool = false
    @Environment(\.imagePipeline) private var imagePipeline
    @Environment(\.colorScheme) private var colorScheme

    private var backdropPath: URL? {
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
                DownloadPlaceHolder()
            }
        }
        .pipeline(imagePipeline)
        .clipped()
        .overlay(
            VStack {
                // Fake Button
                if showPlayButton {
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
                }
            }
        )
        .overlay(alignment: .bottom) {
            // 渐变蒙版
            Group {
                if colorScheme == .dark {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.clear, Assets.Colors.rowBackground]), startPoint: .top, endPoint: .init(x: 0.5, y: 1)))
                        .frame(height: 40)
                }
            }
        }
    }
}

#if DEBUG
    struct MovieNowPlayingBackdrop_Previews: PreviewProvider {
        static var previews: some View {
            NowPlayingBackdrop(
                movie: .previewMovie1
            )
            .frame(width: 390, height: 390 / 1.77)
            .environment(\.colorScheme, .dark)
        }
    }
#endif
