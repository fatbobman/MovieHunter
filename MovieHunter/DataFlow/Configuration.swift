//
//  Configuration.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI

final class Configuration: ObservableObject {
    @AppStorage("colorScheme") var colorScheme: ColorSchemeSetting = .system
}
