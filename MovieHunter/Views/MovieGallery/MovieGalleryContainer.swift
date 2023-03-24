//
//  MovieGalleryContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/24.
//

import Foundation
import SwiftUI
import TMDb

struct MovieGalleryContainer: View {
    let movies:AnyRandomAccessCollection<Movie>
    @Environment(\.deviceStatus) private var deviceStatus
    
    var body: some View {
        switch deviceStatus {
        case .macOS,.regular:
            GalleryLazyVGrid(movies: movies)
        case .compact:
            GalleryLazyVGrid(movies: movies)
        }
    }
}

struct GalleryLazyVGrid:View {
    let movies:AnyRandomAccessCollection<Movie>
    private let minWidth:CGFloat = DisplayType.portrait(.middle).imageSize.width + 10
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: [.init(.adaptive(minimum: minWidth))],spacing: 20){
                ForEach(movies) { movie in
                    MovieItem(movie: movie, displayType: .portrait(.middle))
                }
            }
        }
    }
}

struct GalleryLazyVStack:View {
    var body: some View {
        Text("ss")
    }
}

//struct MovieGalleryContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieGalleryContainer()
//    }
//}
