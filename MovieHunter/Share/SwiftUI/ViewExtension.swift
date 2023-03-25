//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/14.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func setBackdropSize() -> some View {
        modifier(SetBackdropSizeModifier())
    }

    @ViewBuilder
    func safeTask(priority: _Concurrency.TaskPriority = .userInitiated, @_inheritActorContext _ action: @escaping @Sendable () async -> Void) -> some View {
        if #available(iOS 16.4, macOS 13.3, *) {
            self
                .task(priority: priority, action)
        } else {
            onAppear {
                Task(priority: priority, operation: action)
            }
        }
    }
}

struct SetBackdropSizeModifier:ViewModifier {
    @Environment(\.deviceStatus) var deviceStatus
    @State var size:CGSize = .zero
    func body(content: Content) -> some View {
        switch deviceStatus {
        case .compact:
            content
                .environment(\.backdropSize, size)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .task(id:proxy.size.width){ [size] in
                                if size.width != proxy.size.width {
                                    let width = proxy.size.width
                                    self.size = .init(width: width, height: width / (16/9))
                                }
                            }
                    }
                )
                
        default:
            content
        }
    }
}
