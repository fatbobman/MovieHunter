//
//  DebugResources.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

#if DEBUG
    import Foundation
    import TMDb

let movieData = Movie(id: 315162, title: "Puss in Boots: The Last Wish", tagline: nil, originalTitle: "Puss in Boots: The Last Wish", originalLanguage: "en", overview: "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.", runtime: nil, genres: nil, releaseDate: Date.now, posterPath: URL(string:"/kuf6dutpsT0vSVehic3EZIqkOBt.jpg")!, backdropPath: URL(string:"/jr8tSoJGj33XLgFBy6lmZhpGQNu.jpg")!, budget: nil, revenue: nil, homepageURL: nil, imdbID: nil, status: nil, productionCompanies: nil, productionCountries: nil, spokenLanguages: nil, popularity: 1972.345, voteAverage: 8.4, voteCount: 4613, video: false, adult: false)

    enum PreviewData {
        static let portraitImageURL = URL(string: "https://image.tmdb.org/t/p/w300/iOcbJ5pxokOPDRgieVDbsFMrCc6.jpg")!
        static let peopleImageURL = URL(string: "https://image.tmdb.org/t/p/w300/kU3B75TyRiCgE270EyZnHjfivoq.jpg")!
        static let previewMovieName = "The lengend of 1900"
        static let previewMovie = movieData
        static let previewPerson = Person(id: 100, name: "Brad Pitt")
    }

#endif
