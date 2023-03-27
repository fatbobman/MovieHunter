//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/14.
//

import Foundation
import Nuke
import NukeUI
import SwiftUI
import TMDb

struct PersonPortrait: View {
    let personID: Int?
    let name: String?
    let baseURL: URL = .init(string: "https://image.tmdb.org/t/p/w300")!
    let displayType: DisplayType
    @State private var imageURL: URL?
    @Environment(\.tmdb) private var tmdb

    var body: some View {
        VStack(spacing: 10) {
            PeopleImage(imageURL: imageURL, displayType: displayType)
                .frame(width: imageSize.width, height: imageSize.height)
                .clipped()
            PersonName(name: name)
                .frame(width: imageSize.width)
        }
        .task {
            if let personID, let url = try? await tmdb.people.images(forPerson: personID).profiles.first?.filePath {
                imageURL = baseURL.appending(path: url.absoluteString)
            }
        }
    }

    var imageSize: CGSize {
        switch displayType {
        default:
            return .init(width: DisplayType.landscape.imageSize.width, height: DisplayType.landscape.imageSize.height)
        }
    }
}

struct PeopleImage: View {
    let imageURL: URL?
    let displayType: DisplayType
    @Environment(\.imagePipeline) var pipeline
    var body: some View {
        LazyImage(url: imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Color("imagePlaceHolderColor").gradient)
            }
        }
        .pipeline(pipeline)
    }
}

struct FavoriteButton: View {
    let personID: Int?
    let isFavorite: Bool
    var updateFavorite: (Int) -> Void

    var body: some View {
        Circle()
            .fill(.black.opacity(0.6))
            .frame(width: 28, height: 28)
            .overlay(
                Circle()
                    .stroke(.white.opacity(0.1), lineWidth: 2)
            )
            .overlay(
                Image(systemName: "heart")
                    .bold()
                    .foregroundColor(.white)
            )
            .overlay(
                VStack {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .bold()
                            .foregroundColor(Assets.Colors.favorite)
                            .transition(.scale(scale: 1.7).combined(with: .opacity))
                    }
                }
                .animation(.spring(), value: isFavorite)
            )
            .contentShape(Circle())
            .onTapGesture {
                guard let personID else { return }
                updateFavorite(personID)
            }
    }
}

struct PersonName: View {
    let name: String?
    var body: some View {
        Text(name ?? "EmptyLocalizableString")
            .lineLimit(1)
            .font(.caption)
    }
}

#if DEBUG
    struct PersonPortraitPreviewWrapper: View {
        var body: some View {
            VStack {
                PersonPortrait(
                    personID: PreviewData.previewPerson.id,
                    name: "fatbobman",
                    displayType: .landscape
                )
            }
        }
    }

    struct PersonPortrait_Previews: PreviewProvider {
        static var previews: some View {
            PersonPortraitPreviewWrapper()
        }
    }
#endif
