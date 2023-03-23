//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/15.
//

import Foundation
import SwiftUI

struct RateView: View {
    let rate: Double
    let participants: Int?
    var body: some View {
        VStack {
            Image(systemName: "star")
                .symbolVariant(.fill)
                .foregroundColor(Color("starYellow"))
                .font(.title3)
            HStack(alignment: .lastTextBaseline, spacing: 0) {
                rateNumber
                totalView
            }
            participantsView
        }
    }

    var rateNumber: some View {
        Text(rate, format: .number.precision(.fractionLength(1)))
            .font(.title2)
            .foregroundColor(.primary)
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
        }
    }
}

#if DEBUG
    struct RateViewPreview: PreviewProvider {
        static var previews: some View {
            RateView(rate: 9.5, participants: 268_935)
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
#endif
