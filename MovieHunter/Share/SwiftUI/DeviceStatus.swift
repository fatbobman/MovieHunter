//
//  File.swift
//  
//
//  Created by Yang Xu on 2023/3/13.
//

import SwiftUI

public enum DeviceStatus: String {
  case tvOS
  case macOS
  case compact
  case regular
}

struct DeviceStatusKey: EnvironmentKey {
  #if os(macOS)
    static var defaultValue: DeviceStatus = .macOS
  #elseif os(tvOS)
    static var defaultValue: DeviceStatus = .tvOS
  #else
    static var defaultValue: DeviceStatus = .compact
  #endif
}

public extension EnvironmentValues {
  var deviceStatus: DeviceStatus {
    get { self[DeviceStatusKey.self] }
    set { self[DeviceStatusKey.self] = newValue }
  }
}

public extension View {
  @ViewBuilder
  func setDeviceStatus() -> some View {
    self
    #if os(macOS)
    .environment(\.deviceStatus, .macOS)
    #elseif os(tvOS)
    .environment(\.deviceStatus, .tvOS)
    #else
    .modifier(GetSizeClassModifier())
    #endif
  }
}

#if os(iOS)
  struct GetSizeClassModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State var currentSizeClass: DeviceStatus = .compact
    func body(content: Content) -> some View {
      content
        .task(id: sizeClass) {
          if let sizeClass {
            switch sizeClass {
            case .compact:
              currentSizeClass = .compact
            case .regular:
              currentSizeClass = .regular
            default:
              currentSizeClass = .compact
            }
          }
        }
        .environment(\.deviceStatus, currentSizeClass)
    }
  }
#endif

