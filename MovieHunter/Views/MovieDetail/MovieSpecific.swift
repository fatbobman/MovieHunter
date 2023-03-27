//
//  MovieSpecific.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct MovieSpecific: View {
    let movie: Movie
    var body: some View {
        DetailRow(title: "Detail_Specific_Label") {
            releaseDate
            runtime
            budget
            productionCompanies
            Color.clear.frame(height: 10)
        }
    }

    func textContent(_ title: LocalizedStringKey, _ content: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(content)
                .foregroundColor(.secondary)
        }
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    var releaseDate: some View {
        if let releaseDate = movie.releaseDate {
            let releaseDateString = releaseDate.formatted(.dateTime.year().month().day())
            textContent("Detail_ReleaseDate", releaseDateString)
                .padding(10)
            divider
        }
    }

    @ViewBuilder
    var runtime: some View {
        if let duration = movie.runtime {
            let now = Date(timeIntervalSince1970: 0)
            let later = now + TimeInterval(duration) * 60
            let timeDuration = (now ..< later).formatted(.components(style: .narrow))
            textContent("Detail_Runtime", timeDuration)
                .padding(10)
            divider
        }
    }

    @ViewBuilder
    var budget: some View {
        if let budget = movie.budget, budget > 0 {
            let budgetString = budget.formatted(.currency(code: "usd"))
            textContent("Detail_Budget", budgetString)
                .padding(10)
            divider
        }
    }

    @ViewBuilder
    var productionCompanies: some View {
        if let productionCompanies = movie.productionCompanies,!productionCompanies.isEmpty {
            let productionCompaniesString = productionCompanies.map(\.name).formatted(.list(type: .and))
            textContent("Detail_ProductionCompany", productionCompaniesString)
                .padding(10)
        }
    }

    var divider: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Assets.Colors.outline)
            .frame(height: 0.5)
    }
}

struct MovieSpecific_Previews: PreviewProvider {
    static var previews: some View {
        MovieSpecific(movie: PreviewData.previewMovie1)
    }
}
