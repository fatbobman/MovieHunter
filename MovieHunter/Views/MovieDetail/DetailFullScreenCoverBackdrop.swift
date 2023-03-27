//
//  DetailFullScreenCoverBackdrop.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import Nuke
import NukeUI
import SwiftUI
import SwiftUIOverlayContainer

struct BigBackdrop: View {
    let url: URL
    @Environment(\.imagePipeline) private var pipeline
    @Environment(\.overlayContainer) var container
    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
        .frame(width: container.containerFrame.width, height: container.containerFrame.height)
    }
}

extension BigBackdrop: ContainerViewConfigurationProtocol {
    var dismissGesture: ContainerViewDismissGesture? {
        .tap
    }

    var transition: AnyTransition? {
        .opacity
    }
}

struct BigBackdrop_Previews: PreviewProvider {
    static var previews: some View {
        BigBackdrop(url: URL(string: "https://image.tmdb.org/t/p/w1280/74q0L86HV4ifAO0rSRD64iWhVVH.jpg")!)
    }
}
