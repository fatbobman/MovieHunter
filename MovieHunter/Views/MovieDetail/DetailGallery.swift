//
//  DetailGallery.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import Nuke
import NukeUI
import SwiftUI
import TMDb

struct DetailGallery: View {
    let movie: Movie
    @State var urls = [URL]()
    @Environment(\.tmdb) private var tmdb
    @Environment(\.imagePipeline) private var pipeline
    @Environment(\.deviceStatus) private var deviceStatus
    private let baseURL: URL = .init(string: "https://image.tmdb.org/t/p/w300")!
    private var compact: Bool {
        deviceStatus == .compact
    }

    var body: some View {
        VStack {
            if compact {
                DetailRow(title: "Detail_Gallery") {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(urls) { url in
                                poster(url: url)
                            }
                        }
                    }
                    .padding(.bottom,20)
                }
                .frame(height: 250)
            } else {
                ScrollView(.vertical) {
                    VStack(alignment:.leading,spacing: 10) {
                        ForEach(urls) { url in
                            poster(url: url)
                        }
                    }
                    .frame(maxWidth: 400)
                }
            }
        }
        .task {
            if let posters = try? await tmdb.movies.images(forMovie: movie.id).backdrops {
                self.urls = posters.map(\.filePath)
            }
        }
    }

    @MainActor
    @ViewBuilder
    func poster(url: URL) -> some View {
        let url = baseURL.appending(path: url.absoluteString)
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .pipeline(pipeline)
    }
}

#if DEBUG
    struct DetailGallery_Previews: PreviewProvider {
        static var previews: some View {
            DetailGallery(movie: PreviewData.previewMovie1)
        }
    }
#endif
