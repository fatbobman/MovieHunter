//
//  URL.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation

extension URL: Identifiable {
    public var id: String {
        absoluteString
    }
}
