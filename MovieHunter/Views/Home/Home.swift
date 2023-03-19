//
//  Home.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI

struct HomeRoot: View {
    @EnvironmentObject var store:Store
    @State var size:CGSize = .zero
    var genres:[Genres] {
        Genres
            .allCases
            .filter{ store.state.configuration.genres.contains($0.id)
            }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                ForEach(Category.allCases){ category in
                    CategoryWrapper(category: category)
                }
                ForEach(genres,id:\.id) { genre in
                    Text(genre.localizedString)
                }
//                MovieNowPlayingContainer()
            }
//            .frame(width:size.width)
        }
        .background(
            GeometryReader{ proxy in
                Color.clear
                    .task(id: proxy.size){
                        self.size = proxy.size
                    }
            }
        )
        
    }
}

struct HomeRoot_Previews: PreviewProvider {
    static var previews: some View {
        HomeRoot()
            .environmentObject(Store.share)
    }
}
