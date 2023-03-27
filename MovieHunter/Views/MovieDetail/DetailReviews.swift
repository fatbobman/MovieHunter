//
//  DetailReviews.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct DetailReviews: View {
    let reviews: [Review]
    @Environment(\.tmdb) private var tmdb
    var body: some View {
        DetailRow(title:"Detail_Review_Label") {
            ViewThatFits(in: .horizontal) {
                reviewList
                ScrollView(.horizontal) {
                    reviewList
                }
            }
            .padding(.bottom, 10)
        }
    }

    var reviewList: some View {
        LazyHStack(spacing: 10) {
            ForEach(reviews) { review in
                LazyHStack {
                    ReviewContainer(review: review)
                }
                .padding(.bottom, 10)
            }
        }
    }
}

struct ReviewContainer: View {
    let review: Review
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(review.author)
                .lineLimit(1)
            Text(review.content)
                .foregroundColor(.secondary)
            Spacer()
        }
        .font(.footnote)
        .padding(20)
        .frame(width: 200, height: 150, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 3)
                .stroke(Assets.Colors.outline)
        )
    }
}

#if DEBUG
    struct DetailReviews_Previews: PreviewProvider {
        static var previews: some View {
            ReviewContainer(review: .init(id: "abc", author: "fatbobman", content: "I love this movie!"))
        }
    }
#endif
