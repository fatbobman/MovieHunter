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
    static var tmdbConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 1024 * 1024 * 100)
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        return configuration
    }

    static var defaultValue = TMDbAPI(apiKey: tmdbAPIKey, configuration: tmdbConfiguration)
}

extension EnvironmentValues {
    var tmdb: TMDbAPI {
        get { self[TMDBKey.self] }
        set { self[TMDBKey.self] = newValue }
    }
}
