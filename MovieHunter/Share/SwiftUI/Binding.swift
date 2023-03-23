//
//  Binding.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/23.
//

import Foundation
import SwiftUI

extension Binding {
    static func isPresented<V>(_ value: Binding<V?>) -> Binding<Bool> {
        Binding<Bool>(
            get: { value.wrappedValue != nil },
            set: {
                if !$0 { value.wrappedValue = nil }
            }
        )
    }
}
