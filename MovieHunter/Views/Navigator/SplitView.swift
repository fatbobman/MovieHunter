//
//  SplitView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SplitViewContainer: View {
    var body: some View {
        NavigationSplitView {
            SideBar()
                .navigationSplitViewColumnWidth(ideal: 240)
                .toolbar(.hidden, for: .navigationBar)
        } detail: {
            StackContainer()
        }
    }
}

struct SplitViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        SplitViewContainer()
            .environmentObject(Store.share)
    }
}
