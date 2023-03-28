//
//  SettingLibrary.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/28.
//

import Foundation
import SwiftUI

struct SettingLibrary: View {
    var body: some View {
        List {
            Link("Nuke", destination: URL(string: "https://github.com/kean/Nuke")!)
            Link("TMDb", destination: URL(string: "https://github.com/adamayoung/TMDb")!)
            Link("SwiftUI Overlay Container", destination: URL(string: "https://github.com/fatbobman/SwiftUIOverlayContainer")!)
        }
    }
}

struct SettingLibrary_Previews: PreviewProvider {
    static var previews: some View {
        SettingLibrary()
    }
}
