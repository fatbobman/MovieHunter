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
            Section {
                LabeledContent("asdg sd"){
                    Text("\(tmdbCache)")
                    Text("asdg asdg asdg asdg asdg  asdgasd asg")
                }
                LabeledContent{
                    Text(" asdg asdgl;jasdg ;lksdg ")
                    Text("asdg asdg asdg asdg asdg  asdgasd asg")
                } label: {
                    Text("\(tmdbCache)")
                }
            }
           
            Text("\(pipelineCache)")
        }
        .formStyle(.grouped)
        .onAppear {
            pipelineCache = loadPipelineCacheCost()
            tmdbCache = loadURLCacheCost()
        }
    }

    func loadPipelineCacheCost() -> String {
        guard let dataCache = pipeline.configuration.dataCache as? DataCache else { return "unknown" }
        return formatter.string(fromByteCount: Int64(dataCache.totalSize))
    }

    func loadURLCacheCost() -> String {
        formatter.string(fromByteCount: Int64(urlCache.currentDiskUsage))
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
