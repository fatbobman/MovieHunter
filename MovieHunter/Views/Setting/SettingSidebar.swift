//
//  SettingSidebar.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SettingSidebar: View {
    @State var currentCategory: SettingCategory?
    var body: some View {
        List {
            NavigationLink(value: SettingCategory.appearance) {
                Label(SettingCategory.appearance.localizedString, systemImage: "textformat")
            }

            NavigationLink(value: SettingCategory.genres) {
                Label(SettingCategory.genres.localizedString, systemImage: "list.and.film")
            }

            NavigationLink(value: SettingCategory.storage) {
                Label(SettingCategory.storage.localizedString, systemImage: "opticaldiscdrive.fill")
            }

            NavigationLink(value: SettingCategory.library) {
                Label(SettingCategory.library.localizedString, systemImage: "building.columns.fill")
            }
            
            NavigationLink(value: SettingCategory.about) {
                Label(SettingCategory.about.localizedString, systemImage: "person.fill")
            }
        }
        .navigationTitle("Setting_Title")
        #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct SettingSidebar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingSidebar()
        }
        .environment(\.locale, .init(identifier: "zh-cn"))
    }
}
