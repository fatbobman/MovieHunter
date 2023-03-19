//
//  Configuration.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

final class Configuration: ObservableObject {
    /// colorScheme
    @AppStorage("colorScheme") var colorScheme: ColorSchemeSetting = .system
    /// selected genre
    @AppStorage("genres") var genres:[Int] = Genres.allCases.map{$0.rawValue}
    
}
