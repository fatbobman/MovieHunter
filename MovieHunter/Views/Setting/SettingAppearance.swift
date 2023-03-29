//
//  SettingAppearance.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SettingAppearance: View {
    @StateObject private var configuration = AppConfiguration.share
    var body: some View {
        Form {
            // 语言
            Picker("Setting_ColorScheme_Label", selection: $configuration.colorScheme) {
                ForEach(ColorSchemeSetting.allCases) { colorScheme in
                    Text(colorScheme.localizedString)
                        .tag(colorScheme.rawValue)
                }
            }
            #if os(macOS)
            .pickerStyle(.radioGroup)
            #else
            .pickerStyle(.menu)
            #endif

            // 色彩模式
            Picker("Setting_Language_Label", selection: configuration.$appLanguage) {
                ForEach(AppLanguage.allCases) { language in
                    Text(language.localizedString)
                        .tag(language)
                }
            }
            #if os(macOS)
            .pickerStyle(.radioGroup)
            #else
            .pickerStyle(.menu)
            #endif

            // 是否显示书签
            LabeledContent {
                Toggle("Setting_showBookMark", isOn: configuration.$showBookMarkInPoster)
                    .toggleStyle(.switch)
                    .labelsHidden()
            } label: {
                Text("Setting_showBookMark")
                Text("Setting_showBookMark_Description")
            }
        }
        .navigationTitle(SettingCategory.appearance.localizedString)
        #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
        #else
            .formStyle(.grouped) // for macOS
        #endif
    }
}

struct SettingAppearance_Previews: PreviewProvider {
    static var previews: some View {
        SettingAppearance()
            .environmentObject(Store())
    }
}
