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
        .formStyle(.grouped)
        .onAppear {
            pipelineCache = loadPipelineCacheCost()
            tmdbCache = loadURLCacheCost()
        }
    }

    func loadPipelineCacheCost() -> String {
        var cost = 0
        if let dataCache = pipeline.configuration.dataCache as? DataCache {
            cost = dataCache.totalCount
            print("data cache \(cost)")
        }
        if let imageCache = pipeline.configuration.imageCache as? ImageCache {
            cost += imageCache.totalCost
            print("image cache \(cost)")
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
            print("clean url cache")
        }

        if let imageCache = pipeline.configuration.imageCache as? ImageCache {
            imageCache.removeAll()
            print("clean image cache")
        }

        if let dataCache = pipeline.configuration.dataCache as? DataCache {
            dataCache.removeAll()
            dataCache.flush()
            print("clean data cache")
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
