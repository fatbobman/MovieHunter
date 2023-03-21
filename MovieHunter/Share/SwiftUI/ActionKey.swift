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

struct GoMovieDetailKey: EnvironmentKey {
    static var defaultValue: (Movie) -> Void = {
        #if DEBUG
            print("goto \($0.title)'s detail view")
        #endif
    }
}

struct UpdateMovieWishlistKey: EnvironmentKey {
    static var defaultValue: (Int) -> Void = {
        #if DEBUG
            print("add movie id:\($0) to favorite movie list")
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

extension EnvironmentValues {
    // check if in favorite movie list
    var inWishlist: (Int) -> Bool {
        get { self[InWishlistKey.self] }
        set { self[InWishlistKey.self] = newValue }
    }

    // go to movie detail view
    var goDetail: (Movie) -> Void {
        get { self[GoMovieDetailKey.self] }
        set { self[GoMovieDetailKey.self] = newValue }
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
}
