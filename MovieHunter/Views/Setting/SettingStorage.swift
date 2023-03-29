//
//  SettingNetworkAndStorage.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import Nuke
import SwiftUI

struct SettingStorage: View {
    let urlCache = URLCache.appURLCache
    let pipeline = appPipeline
    @State var tmdbCache: String = ""
    @State var pipelineCache: String = ""
    var body: some View {
        Form {
            Section("Setting_Storage_CleanMovieCache_Section_Title") {
                Text("Setting_Storage_CleanMovieCache_Description").foregroundColor(.secondary) + Text(tmdbCache)

                Button("Setting_Storage_CleanMovieCache_CleanButton") {
                    emptyMovieCache()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
            }

            Section("Setting_Storage_CleanImageCache_Section_Title") {
                Text("Setting_Storage_CleanImageCache_Description").foregroundColor(.secondary) + Text(pipelineCache)

                Button("Setting_Storage_CleanImageCache_CleanButton") {
                    emptyImageCache()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            tmdbCache = loadURLCacheCost()
            pipelineCache = loadPipelineCacheCost()
        }
        .navigationTitle(SettingCategory.storage.localizedString)
        #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
        #else
            .formStyle(.grouped) // for macOS
        #endif
    }

    func loadPipelineCacheCost() -> String {
        var cost = 0
        if let dataCache = pipeline.configuration.dataCache as? DataCache {
            cost = dataCache.totalCount
        }
        if let imageCache = pipeline.configuration.imageCache as? ImageCache {
            cost += imageCache.totalCost
        }
        return formatter.string(fromByteCount: Int64(cost))
    }

    func loadURLCacheCost() -> String {
        formatter.string(fromByteCount: Int64(urlCache.currentDiskUsage))
    }

    func emptyMovieCache() {
        urlCache.removeAllCachedResponses()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            tmdbCache = loadURLCacheCost()
        }
    }

    func emptyImageCache() {
        if let dataLoader = pipeline.configuration.dataLoader as? DataLoader {
            dataLoader.session.configuration.urlCache?.removeAllCachedResponses()
        }

        if let imageCache = pipeline.configuration.imageCache as? ImageCache {
            imageCache.removeAll()
        }

        if let dataCache = pipeline.configuration.dataCache as? DataCache {
            dataCache.removeAll()
            dataCache.flush()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            pipelineCache = loadPipelineCacheCost()
        }
    }

    let formatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .binary
        formatter.includesUnit = true
        formatter.isAdaptive = true
        return formatter
    }()
}

struct SettingStorage_Previews: PreviewProvider {
    static var previews: some View {
        SettingStorage()
    }
}
