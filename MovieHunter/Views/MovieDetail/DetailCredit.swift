//
//  PersonList.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct DetailCredit: View {
    let movie: Movie
    @State private var person = [Person]()
    @Environment(\.tmdb) private var tmdb
    @State private var casts = [CastMember]()
    @State private var crews = [CrewMember]()

    private var directors: [CrewMember] {
        crews.filter { $0.job == "Director" }
    }

    private var writers: [CrewMember] {
        crews.filter { $0.job == "Writer" }
    }

    var body: some View {
        DetailRow(title: "Detail_Cast_Label") {
            CastList(casts: casts)
            divider
            directorView
            divider
            writerView
                .padding(.bottom, 10)
        }
        .task {
            if let showCredits = try? await tmdb.movies.credits(forMovie: movie.id) {
                self.casts = showCredits.cast
                self.crews = showCredits.crew
            }
        }
    }

    var divider: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Assets.Colors.outline)
            .frame(height: 0.5)
    }

    var directorView: some View {
        HStack {
            Text("Detail_Director") + Text(verbatim: ":")
            Text(directors.map(\.name), format: .list(type: .and))
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var writerView: some View {
        HStack {
            Text("Detail_Writer") + Text(verbatim: ":")
            Text(writers.map(\.name), format: .list(type: .and))
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CastList: View {
    let casts: [CastMember]
    var body: some View {
        ViewThatFits(in: .horizontal) {
            images
            ScrollView(.horizontal) {
                images
            }
        }
    }

    var images: some View {
        LazyHStack {
            if casts.isEmpty {
                PersonPortrait(personID: nil, name: nil, displayType: .landscape)
            }
            ForEach(casts) { cast in
                PersonPortrait(personID: cast.id, name: cast.name, displayType: .landscape)
                    .padding(.bottom, 10)
            }
        }
    }
}

struct DetailPersonList_Previews: PreviewProvider {
    static var previews: some View {
        DetailCredit(movie: .previewMovie1)
            .border(.red)
    }
}
