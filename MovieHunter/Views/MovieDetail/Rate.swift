//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/15.
//

import Foundation
import SwiftUI

struct RateView: View {
    let rate: Double?
    let participants: Int?
    let type: RateType
    let showStar: Bool
    init(rate: Double?, participants: Int?, type: RateType = .horizontal, showStar: Bool = false) {
        self.rate = rate
        self.participants = participants
        self.type = type
        self.showStar = showStar
    }

    var layout: AnyLayout {
        type == .horizontal ? AnyLayout(HStackLayout(alignment: .firstTextBaseline)) : AnyLayout(VStackLayout())
    }

    var body: some View {
        layout {
            if showStar {
                Image(systemName: "star")
                    .symbolVariant(.fill)
                    .foregroundColor(Color("starYellow"))
                    .font(.title3)
            }
            HStack(alignment: .lastTextBaseline, spacing: 0) {
                rateNumber
                totalView
            }
            participantsView
        }
    }

    var rateNumber: some View {
        Group {
            if let rate {
                Text(rate, format: .number.precision(.fractionLength(1)))
                    .font(.title2)
                    .foregroundColor(.primary)
            } else {
                Text(verbatim: "NIL")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }

    var totalView: some View {
        HStack(spacing: 0) {
            Text("/")
                .alignmentGuide(.lastTextBaseline) { $0[.lastTextBaseline] - 5 }
            Text("10")
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }

    @ViewBuilder
    var participantsView: some View {
        if let participants {
            Text(participants, format: .number)
                .if(type == .horizontal) {
                    $0
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
        }
    }

    enum RateType {
        case horizontal
        case vertical
    }
}

#if DEBUG
    struct RateViewPreview: PreviewProvider {
        static var previews: some View {
            RateView(rate: 9.5, participants: 268_935)
                .foregroundColor(.secondary)
                .font(.footnote)

            RateView(rate: nil, participants: nil)
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
#endif
