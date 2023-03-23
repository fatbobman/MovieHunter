//
//  ButtonStyle.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/23.
//

import Foundation
import SwiftUI

struct FlatButtonStyle:ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

extension ButtonStyle where Self == FlatButtonStyle {
    static var flat:FlatButtonStyle {
        FlatButtonStyle()
    }
}
