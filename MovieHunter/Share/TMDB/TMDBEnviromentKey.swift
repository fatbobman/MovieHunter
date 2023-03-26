//
//  TMDBEnviromentKey.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import Foundation
import SwiftUI
import TMDb

struct TMDBKey: EnvironmentKey {
    static var defaultValue = TMDbAPI.appDefault
}

extension EnvironmentValues {
    var tmdb: TMDbAPI {
        get { self[TMDBKey.self] }
        set { self[TMDBKey.self] = newValue }
    }
}

extension TMDbAPI {
    static let appDefault = TMDbAPI(apiKey: tmdbAPIKey, configuration: URLSession.tmdbConfiguration)
}

extension URLSession {
    static var tmdbConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache.appURLCache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }
}

extension URLCache {
    static let appURLCache = URLCache(memoryCapacity: 0, diskCapacity: 1024 * 1024 * 100)
}
