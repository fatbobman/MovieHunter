//
//  GenreList.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct GenreList: View {
    private let genres: [Genre]
    init(genres: [Genre]?) {
        self.genres = genres ?? []
    }

    @Environment(\.tmdb) private var tmdb
    var body: some View {
        ViewThatFits(in: .horizontal) {
            genresList
            ScrollView(.horizontal, showsIndicators: false) {
                genresList
            }
        }
    }

    var genresList: some View {
        HStack {
            ForEach(genres) { genre in
                Text(genre.name)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Assets.Colors.outline)
                    )
            }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

#if DEBUG
struct GenreList_Previews: PreviewProvider {
    static var previews: some View {
        GenreList(genres: [
            .init(id: 12, name: "动画"),
            .init(id: 23, name: "冒险"),
            .init(id: 35, name: "家庭"),
        ]
        )
        .padding(10)

        GenreList(genres: [
            .init(id: 12, name: "动画"),
            .init(id: 23, name: "冒险"),
            .init(id: 35, name: "家庭"),
        ]
        )
        .padding(10)
        .frame(width: 150)
    }
}
#endif
