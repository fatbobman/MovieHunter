//
//  ButtonStyle.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/23.
//

import Foundation
import SwiftUI

struct FlatButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct PressStatusStyle: ButtonStyle {
    @Binding var isPressed: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                VStack {
                    if configuration.isPressed {
                        Color.white.frame(width: 0.1,height: 0.1).opacity(0.0001)
                    } else {
                        Color.secondary.frame(width: 0.1,height: 0.1).opacity(0.0001)
                    }
                }
            )
            .task(id:configuration.isPressed){
                self.isPressed = configuration.isPressed
            }
    }
}

extension ButtonStyle where Self == FlatButtonStyle {
    static var flat: FlatButtonStyle {
        FlatButtonStyle()
    }

    static func pressStatus(_ isPressed: Binding<Bool>) -> PressStatusStyle {
        PressStatusStyle(isPressed: isPressed)
    }
}
