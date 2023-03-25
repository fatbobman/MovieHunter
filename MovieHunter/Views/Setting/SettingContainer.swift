//
//  SettingContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SettingContainer: View {
    var body: some View {
        NavigationSplitView {
            Text("d")
        } detail: {
            Text("s")
        }
    }
}

struct SettingContainer_Previews: PreviewProvider {
    static var previews: some View {
        SettingContainer()
    }
}
