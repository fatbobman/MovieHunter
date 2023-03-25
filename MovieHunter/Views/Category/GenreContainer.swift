//
//  GenreContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/21.
//

import Foundation
import SwiftUI
import TMDb

struct GenreContainer: View {
    let genreID:Int
    
    private var genreTitle:LocalizedStringKey {
        Genres(rawValue: genreID)?.localizedString ?? "EmptyLocalizableString"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ViewMoreButton(
                title: genreTitle,
                destination: .genre(genreID)
            )
            GenreScrollView(genreID: genreID)
        }
        .background(Assets.Colors.rowBackground)
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
struct GenreContainer_Previews: PreviewProvider {
    static var previews: some View {
        GenreContainer(genreID: 12)
    }
}
#endif
