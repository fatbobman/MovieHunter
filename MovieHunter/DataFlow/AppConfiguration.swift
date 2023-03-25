//
//  Configuration.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

final class AppConfiguration: ObservableObject {
    /// colorScheme
    @AppStorage("colorScheme") var colorScheme: ColorSchemeSetting = .system
    /// selected genre
    @AppStorage("genres") var genres: [Int] = Genres.allCases.map { $0.rawValue }
    /// show adult movie
    @AppStorage("showAdultMovieInResult") var showAdultMovieInResult = false
    /// genre sortBy
    @AppStorage("genre_sortBy") var genre_sortBy: Genre_SortBy = .byPopularity
    /// show book mark button in movie poster
    @AppStorage("show_favorite_button_in_movie_poster") var show_favorite_button_in_movie_poster = true
    /// show book mark button in person poster
    @AppStorage("show_favorite_button_in_person_poster") var show_favorite_button_in_person_poster = true
    /// open in new window on macOS
    @AppStorage("open_in_new_window") var open_in_new_window = false
}
