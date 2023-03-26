//
//  SettingGenre.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SettingGenres: View {
    @StateObject private var configuration = AppConfiguration.share
    @State var genres: [SelectedGenre] = []

    var body: some View {
        Form {
            Section("Setting_Genre_In_Home") {
                ForEach($genres) { $genre in
                    Toggle(genre.genre.localizedString,isOn: $genre.showInHome)
                }
            }
        }
        .onAppear {
            let selected = AppConfiguration.share.genres
            let genres = Genres.allCases.map {
                SelectedGenre(genre: $0, updateHandler: handler, showInHome: selected.contains($0.id))
            }
            self.genres = genres
        }
        .formStyle(.grouped)
    }

    func handler(genre: Genres) {
        if let index = configuration.genres.firstIndex(where: { $0 == genre.id }) {
            configuration.genres.remove(at: index)
        } else {
            configuration.genres.append(genre.id)
        }
    }
}

struct SelectedGenre: Identifiable {
    var id: Int {
        genre.id
    }

    let genre: Genres
    let updateHandler: (Genres) -> Void
    var showInHome: Bool {
        didSet {
            updateHandler(genre)
        }
    }
}

struct SettingGenres_Previews: PreviewProvider {
    static var previews: some View {
        SettingGenres()
    }
}
