//
//  TMDBConfiguration.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import Foundation

let tmdbAPIKey = "703f9b5b31d0f32feb52b4cfab42e343"
let moviePosterURLPrefix = URL(string: "https://image.tmdb.org/t/p")!

enum TMDBImageSize:String {
    case w300 = "/w300/"
    case w1280 = "/w1280/"
}

func imageBaseURL(_ size:TMDBImageSize) -> URL {
    moviePosterURLPrefix.appending(path: size.rawValue)
}
