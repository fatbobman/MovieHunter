//
//  SideBar.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SideBar: View {
    @AppStorage("genres") private var genres: [Int] = Genres.allCases.map { $0.rawValue }
    @Environment(\.goCategory) private var goCategory

    var showableGenres: [Genres] {
        Genres
            .allCases
            .filter { genres.contains($0.id)
            }
    }

    var body: some View {
        List {
            ForEach(Category.showableCategory) { category in
                Button {
                    goCategory(category.destination)
                } label: {
                    Text(category.localizedString)
                }
            }

            Section("SideBar_Genre_Section_Label") {
                // TODO: 根据设定过过滤
                ForEach(showableGenres) { genre in
                    Button {
                        goCategory(.genre(genre.id))
                    } label: {
                        Text(genre.localizedString)
                    }
                }
            }
        }
        .listStyle(.sidebar)
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
    }
}
