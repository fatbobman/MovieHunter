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
    let person: Person?
    let imageURL: URL?
    let displayType: DisplayType
    let isFavorite: Bool
    var updateFavorite: (Int) -> Void

    var body: some View {
        VStack(spacing: 10) {
            PeopleImage(imageURL: imageURL, displayType: displayType)
                .frame(width: imageSize.width, height: imageSize.height)
                .clipped()
                .overlay(alignment: .bottomLeading) {
                    FavoritButton(personID: person?.id, isFavorite: isFavorite, updateFavorite: updateFavorite)
                        .offset(x: 3, y: -3)
                }
            PersonName(person: person)
                .frame(width: imageSize.width)
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

struct FavoritButton: View {
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
    let person: Person?
    var body: some View {
        Text(person?.name ?? "")
            .lineLimit(1)
            .font(.caption)
    }
}

#if DEBUG
    struct PersonPortraitPreviewWrapper: View {
        var isFavorite: Bool {
            if let id = person?.id {
                return favorite.contains(id)
            } else { return false }
        }

        @State var person: Person?
        @State var personImageURL: URL?
        @State var favorite = Set<Int>()
        var body: some View {
            VStack {
                PersonPortrait(
                    person: person,
                    imageURL: personImageURL,
                    displayType: .landscape,
                    isFavorite: isFavorite,
                    updateFavorite: { id in
                        if favorite.contains(id) {
                            favorite.removeAll()
                        } else {
                            favorite.insert(id)
                        }
                    }
                )

                Button("Switch Person") {
                    if person != nil {
                        person = nil
                        personImageURL = nil
                        if let id = person?.id {
                            favorite.insert(id)
                        }
                    } else {
                        person = PreviewData.previewPerson
                        personImageURL = PreviewData.peopleImageURL
                        favorite.removeAll()
                    }
                }
            }
        }
    }

    struct PersonPortrait_Previews: PreviewProvider {
        static var previews: some View {
            PersonPortraitPreviewWrapper()
        }
    }
#endif
