//
//  MenuBar.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI

#if os(macOS)
    let windowGroupID = "categoryGroup"
    struct MenuBar: View {
        @Environment(\.openWindow) var openWindow
        var body: some View {
            ForEach(Category.showableCategory) { category in
                Button {
                    openWindow(id: windowGroupID, value: category)
                } label: {
                    Text(category.localizedString)
                }
            }
            Menu {
                ForEach(Genres.allCases) { genre in
                    Button {
                        openWindow(id: windowGroupID, value: Category.genre(genre.id))
                    } label: {
                        Text(genre.localizedString)
                    }
                }
            } label: {
                Text("SideBar_Genre_Section_Label")
            }
            Divider()
            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Text("Quit_App")
            }
        }
    }
#endif

#if DEBUG && os(macOS)
    struct MenuBar_Previews: PreviewProvider {
        static var previews: some View {
            Form {
                MenuBar()
            }
            .formStyle(.grouped)
        }
    }
#endif
