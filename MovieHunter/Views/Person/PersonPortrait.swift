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

struct PersonPortrait: View {
    let imageURL: URL
    let name: String
    let displayType: DisplayType
    var body: some View {
        VStack(spacing: 10) {
            PeopleImage(imageURL: imageURL, displayType: displayType)
                .frame(width: imageSize.width, height: imageSize.height)
                .clipped()
                .overlay(alignment: .bottomLeading) {
                    FavoritButton()
                        .offset(x: 3, y: -3)
                }
            PersonName(name: name)
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
    let imageURL: URL
    let displayType: DisplayType
    @Environment(\.imagePipeline) var pipeline
    var body: some View {
        LazyImage(url: imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color("imagePlaceHolderColor")
            }
        }
        .pipeline(pipeline)
    }
}

struct FavoritButton: View {
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
    }
}

struct PersonName: View {
    let name: String
    var body: some View {
        Text(name)
            .lineLimit(1)
            .font(.caption)
    }
}

struct PersonPortrait_Previews: PreviewProvider {
    static var previews: some View {
        PersonPortrait(
            imageURL: PreviewData.peopleImageURL,
            name: "Brad Pitt",
            displayType: .landscape
        )
    }
}
