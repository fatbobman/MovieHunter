//
//  SortBy.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/21.
//

import Foundation
import SwiftUI

enum Genre_SortBy: Int {
    case byPopularity = 0
    case byVoteAverage = 1
    case byReleaseDate = 2

    var localizableString: LocalizedStringKey {
        switch self {
        case .byPopularity:
            return "SortBy_Popularity"
        case .byReleaseDate:
            return "SortBy_ReleaseDate"
        case .byVoteAverage:
            return "SortBy_VoteAverage"
        }
    }
}
