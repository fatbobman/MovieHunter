//
//  SettingAbout.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct About: View {
    var body: some View {
        VStack {
            Image("cartoonHunter")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text("About")
            Text("License")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
