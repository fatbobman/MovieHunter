//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/13.
//

import Foundation
import Nuke
import NukeUI
import SwiftUI

public struct PipelineKey: EnvironmentKey {
    public static var defaultValue: ImagePipeline? = pipeline
}

public extension EnvironmentValues {
    var imagePipeline: ImagePipeline? {
        get { self[PipelineKey.self] }
        set { self[PipelineKey.self] = newValue }
    }
}

public extension LazyImage {
    /// Changes the underlying pipeline used for image loading.
    func pipeline(_ pipelineOptional: ImagePipeline?) -> Self {
        if let pipelineOptional {
            return pipeline(pipelineOptional)
        } else {
            return self
        }
    }
}

let pipeline = ImagePipeline {
    $0.dataLoader = DataLoader(configuration: {
        let conf = DataLoader.defaultConfiguration
        conf.urlCache = nil
        return conf
    }())

    $0.imageCache = ImageCache()
    $0.dataCache = try! DataCache(name: "com.fatbobman.movieHunter.DataCache")
    ($0.dataCache as! DataCache).sizeLimit = 1024 * 1024 * 500
}
