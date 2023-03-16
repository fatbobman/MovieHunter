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
  public static var defaultValue: ImagePipeline?
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
      pipeline(pipelineOptional)
    } else {
      self
    }
  }
}

