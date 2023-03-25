//
//  NavigatorContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct NavigatorContainer: View {
    @Environment(\.deviceStatus) var deviceStatus
    var body: some View {
        switch deviceStatus {
        case .compact:
            StackContainer()
        default:
            SplitViewContainer()
        }
    }
}

struct NavigatorContainer_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorContainer()
    }
}
