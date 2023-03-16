//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/15.
//

import Foundation
import SwiftUI

public struct HalfRoundedRectangle: Shape {
  let cornerRadius: CGFloat
  public init(cornerRadius: CGFloat = 8) {
    self.cornerRadius = cornerRadius
  }

  public func path(in rect: CGRect) -> Path {
    var path = Path()
    let y = max(rect.maxY - cornerRadius, CGFloat(0))
    let center1 = CGPoint(x: rect.maxX - cornerRadius, y: y)
    let center2 = CGPoint(x: cornerRadius, y: y)
    path.move(to: .zero)
    path.addLine(to: .init(x: rect.maxX, y: rect.minY))
    path.addLine(to: .init(x: rect.maxX, y: y))
    path.addArc(center: center1, radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
    path.addLine(to: .init(x: cornerRadius, y: rect.maxY))
    path.addArc(center: center2, radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
    path.addLine(to: .zero)
    return path
  }
}
