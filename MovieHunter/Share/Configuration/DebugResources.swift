//
//  DebugResources.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

#if DEBUG
    import Foundation
    import SwiftUI
    import TMDb

    enum PreviewData {
        static let portraitImageURL = URL(string: "https://image.tmdb.org/t/p/w300/iOcbJ5pxokOPDRgieVDbsFMrCc6.jpg")!
        static let peopleImageURL = URL(string: "https://image.tmdb.org/t/p/w300/kU3B75TyRiCgE270EyZnHjfivoq.jpg")!
        static let previewMovieName = "The legend of 1900"
        static let previewPerson = Person(id: 100, name: "Brad Pitt")
    }

    extension PreviewDevice {
        static let iPhoneName: PreviewDevice = .init(rawValue: "iPhone 14 Pro")
        static let iPadName: PreviewDevice = .init(rawValue: "iPad Pro 11'")
    }

    extension Movie {
        static let previewMovie1 = Movie(id: 315_162, title: "Puss in Boots: The Last Wish", tagline: nil, originalTitle: "Puss in Boots: The Last Wish", originalLanguage: "en", overview: "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.", runtime: nil, genres: [.init(id: 12, name: "Animation"), .init(id: 34, name: "Music")], releaseDate: Date.now, posterPath: URL(string: "/kuf6dutpsT0vSVehic3EZIqkOBt.jpg")!, backdropPath: URL(string: "/jr8tSoJGj33XLgFBy6lmZhpGQNu.jpg")!, budget: nil, revenue: nil, homepageURL: nil, imdbID: nil, status: nil, productionCompanies: nil, productionCountries: nil, spokenLanguages: nil, popularity: 1972.345, voteAverage: 8.4, voteCount: 4613, video: false, adult: false)
        static let previewMovie2 = Movie(id: 758_009, title: "Shotgun Wedding", tagline: nil, originalTitle: "Shotgun Wedding", originalLanguage: "en", overview: "Darcy and Tom gather their families for the ultimate destination wedding but when the entire party is taken hostage, “’Til Death Do Us Part” takes on a whole new meaning in this hilarious, adrenaline-fueled adventure as Darcy and Tom must save their loved ones—if they don’t kill each other first.", runtime: nil, genres: nil, releaseDate: Date.now, posterPath: URL(string: "/t79ozwWnwekO0ADIzsFP1E5SkvR.jpg"), backdropPath: URL(string: "/zGoZB4CboMzY1z4G3nU6BWnMDB2.jpg"), budget: nil, revenue: nil, homepageURL: nil, imdbID: nil, status: nil, productionCompanies: nil, productionCountries: nil, spokenLanguages: nil, popularity: 1079.73, voteAverage: 6.3, voteCount: 666, video: false, adult: false)
    }
#endif
