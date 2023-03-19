//
//  CategoryLabelInHome.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI

struct CategoryLabelInHome: View {
    let category: Category
    var body: some View {
        Color.clear
            .frame(height: 35)
            .frame(maxWidth: .infinity)
            .overlay(
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Assets.Colors.favorite)
                        .frame(width: 4, height: 24)
                    Text(category.localizedString)
                        .font(.title3)
                    Spacer()
                    Button("查看更多") {}
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            )
    }
}

struct CategoryLabelInHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLabelInHome(category: .nowPlaying)
    }
}
