//
//  ActionKey.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/21.
//

import Foundation
import SwiftUI
import TMDb

struct InWishlistKey: EnvironmentKey {
    static var defaultValue: (Int) -> Bool = { _ in true }
}

struct GoMovieDetailFromHomeKey: EnvironmentKey {
    static var defaultValue: (Category, Movie) -> Void = {
        #if DEBUG
            print("goto (\($0)):(\($1.title))'s detail view")
        #endif
    }
}

struct GoMovieDetailFormCategoryKey: EnvironmentKey {
    static var defaultValue: (Movie) -> Void = {
        #if DEBUG
            print("goto (\($0.title))'s detail view")
        #endif
    }
}

struct UpdateMovieWishlistKey: EnvironmentKey {
    static var defaultValue: (Int) -> Void = {
        #if DEBUG
            print("update movie id:\($0) in favorite movie list")
        #endif
    }
}

struct GoCategoryKey: EnvironmentKey {
    static var defaultValue: (Destination) -> Void = {
        #if DEBUG
            print("go to \($0.debugDescription)'s gallery view")
        #endif
    }
}

struct MovieIsLoadingKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

struct BackdropSizeKey: EnvironmentKey {
    static var defaultValue: CGSize = .zero
}

struct OverlayContainerSceneName: EnvironmentKey {
    static var defaultValue: String = UUID().uuidString
}

extension EnvironmentValues {
    // check if in favorite movie list
    var inWishlist: (Int) -> Bool {
        get { self[InWishlistKey.self] }
        set { self[InWishlistKey.self] = newValue }
    }

    // go to movie detail view from home
    var goDetailFromHome: (Category, Movie) -> Void {
        get { self[GoMovieDetailFromHomeKey.self] }
        set { self[GoMovieDetailFromHomeKey.self] = newValue }
    }

    // go to movie detail view from movie gallery
    var goDetailFromCategory: (Movie) -> Void {
        get { self[GoMovieDetailFormCategoryKey.self] }
        set { self[GoMovieDetailFormCategoryKey.self] = newValue }
    }

    // add movie into favorite list
    var updateWishlist: (Int) -> Void {
        get { self[UpdateMovieWishlistKey.self] }
        set { self[UpdateMovieWishlistKey.self] = newValue }
    }

    // go to category gallery view
    var goCategory: (Destination) -> Void {
        get { self[GoCategoryKey.self] }
        set { self[GoCategoryKey.self] = newValue }
    }

    var isLoading: Bool {
        get { self[MovieIsLoadingKey.self] }
        set { self[MovieIsLoadingKey.self] = newValue }
    }

    // set nowPlaying backdrop size in compact mode
    var backdropSize: CGSize {
        get { self[BackdropSizeKey.self] }
        set { self[BackdropSizeKey.self] = newValue }
    }

    // overlay Container name
    var containerName: String {
        get { self[OverlayContainerSceneName.self] }
        set { self[OverlayContainerSceneName.self] = newValue }
    }
}
