//
//  DetailRow.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI

struct DetailRow<Content>: View where Content: View {
    let title: LocalizedStringKey
    let content: () -> Content
    init(title: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ViewMoreButton(
                title: title,
                showViewMoreText: false,
                showArrow: false,
                destination: .nowPlaying,
                clickable: false,
                enableHorizontalPadding: false
            )
            content()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Assets.Colors.rowBackground)
    }
}
