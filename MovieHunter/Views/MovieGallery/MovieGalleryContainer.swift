//
//  MovieGalleryContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/23.
//

import Foundation
import SwiftUI
import TMDb

struct MovieGalleryContainer: View {
    let category: Category

    @Environment(\.deviceStatus) private var deviceStatus
    @Environment(\.tmdb) private var tmdb
    @StateObject private var loader = MoviesGalleryLoader()

    init(category: Category) {
        self.category = category
    }

    private var showInGrid: Bool {
        switch deviceStatus {
        case .compact:
            return false
        default:
            return true
        }
    }

    var body: some View {
        List {
            ForEach(loader) { movie in
                MovieItem(movie: movie, displayType: .landscape)
            }
        }
        .onAppear {
            loader.setLoader(category: category, tmdb: tmdb)
        }
    }
}

struct MovieGalleryContainer_Previews: PreviewProvider {
    static var previews: some View {
        MovieGalleryContainer(category: .topRate)
    }
}

/*
// 三种数据源的包装器： Tmdb、wishlist、favoritePerson
 List
 Grid
 
 
 NavigationStack
 MovieDetail
 PersonDetail
 TabView
 Settings
 NavigationSplitView
 
 
*/
