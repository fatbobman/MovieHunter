//
//  Array.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import TMDb

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

extension Sequence where Iterator.Element == Movie {
    func uniqueMovie() -> [Iterator.Element] {
        var seen: Set<Int> = []
        return filter { seen.insert($0.id).inserted }
    }
}
