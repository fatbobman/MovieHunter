//
//  ErrorHandler.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/24.
//

import Foundation

func withErrorHandling<T>(_ block: @escaping () async throws -> T) async -> T? {
    do {
        return try await block()
    } catch {
        #if DEBUG
            print("An error occurred: \(error)")
        #endif
        return nil
    }
}
