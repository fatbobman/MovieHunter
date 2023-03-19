//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/13.
//

import Foundation
import SwiftUI
import TMDb

struct MovieShortInfo: View {
    let movie: Movie?
    let displayType: DisplayType

    var body: some View {
        switch displayType {
        case .portrait:
            VStack(alignment: .leading, spacing: 8) {
                rateView
                movieNameView.padding(.trailing, 8)
                HStack(alignment: .bottom) {
                    releaseDateView
                    durationView
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 13)
            .frame(width: displayType.imageSize.width, alignment: .leading)
        case .landscape:
            VStack(alignment: .leading, spacing: 8) {
                movieNameView
                HStack(alignment: .bottom, spacing: 8) {
                    rateView
                    releaseDateView
                    durationView
                }
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // 评分
    @ViewBuilder
    var rateView: some View {
        HStack(spacing: 3) {
            if let movie {
                if let rate = movie.voteAverage {
                    Image(systemName: "star")
                        .symbolVariant(.fill)
                        .foregroundColor(.orange)
                    
                    Text(rate, format: .number.precision(.fractionLength(1)))
                } else {
                    Text("")
                        .foregroundColor(.secondary)
                }
            } else {
                Text(" ")
                    .foregroundColor(.secondary)
            }
        }
        .font(.footnote)
    }

    // 电影名称
    @ViewBuilder
    var movieNameView: some View {
        Text(movie?.title ?? " ")
            .font(.callout)
            .lineLimit(1)
    }

    // 发行年份
    @ViewBuilder
    var releaseDateView: some View {
        VStack {
            if let movie {
                if let releaseDate = movie.releaseDate {
                    Text(releaseDate, format: .dateTime.year(.defaultDigits))
                } else {
                    Text("coming soon")
                }
            } else {
                Text(" ")
            }
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }

    // 电影时长
    @ViewBuilder
    var durationView: some View {
        if let movie, let duration = movie.runtime {
            let now = Date(timeIntervalSince1970: 0)
            let later = now + TimeInterval(duration) * 60
            let timeDuration = (now ..< later).formatted(.components(style: .narrow))
            Text(timeDuration)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

#if DEBUG
    struct MovieShortInfoPreview: PreviewProvider {
        static var previews: some View {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(.orange.gradient)
                    .frame(width: DisplayType.landscape.imageSize.width,
                           height: DisplayType.landscape.imageSize.height)
                MovieShortInfo(
                    movie: PreviewData.previewMovie,
                    displayType: .landscape
                )
            }
            .padding(8)
            .frame(width: 393)
            .previewLayout(.sizeThatFits)
            .border(.gray)
            .environment(\.calendar, .init(identifier: .gregorian))
            .environment(\.locale, .init(identifier: "zh-cn"))

            VStack(spacing: 0) {
                Rectangle()
                    .fill(.orange.gradient)
                    .frame(width: DisplayType.portrait(.small).imageSize.width,
                           height: DisplayType.portrait(.small).imageSize.height)
                MovieShortInfo(
                    movie: PreviewData.previewMovie,
                    displayType: .portrait(.small)
                )
            }
            .border(.gray)

            VStack(spacing: 0) {
                Rectangle()
                    .fill(.orange.gradient)
                    .frame(width: DisplayType.portrait(.middle).imageSize.width,
                           height: DisplayType.portrait(.middle).imageSize.height)
                MovieShortInfo(
                    movie: PreviewData.previewMovie,
                    displayType: .portrait(.middle)
                )
            }
            .border(.gray)
        }
    }
#endif
