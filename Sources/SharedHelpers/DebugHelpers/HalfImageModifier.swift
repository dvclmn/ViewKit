//
//  HalfImageView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import SwiftUI

public struct HalfImageBackgroundModifier: ViewModifier {
  let url: URL?
  let balanceFactor: Double
  public func body(content: Content) -> some View {
    content
      .background {
        HStack(spacing: 0) {
          Rectangle().fill(.black.secondary)
            .containerRelativeFrameCompatible(
              .horizontal,
              count: 10,
              span: ,
              spacing: <#T##CGFloat#>,
              alignment: <#T##Alignment#>
            )
          //            .frame(width: width / 2)
          AsyncImage(url: url) {
            $0.image?
              .resizable()
              .aspectRatio(contentMode: .fill)
          }
          //          .frame(width: width / 2)
        }
        
//        Rectangle()
//          .fill(Color.red)
//          .containerRelativeFrame(.vertical, count: 100, span: 43, spacing: 0)
//        
//        Rectangle()
//          .fill(Color.green)
//          .containerRelativeFrame(.vertical, count: 100, span: 37, spacing: 0)
//        
//        Rectangle()
//          .fill(Color.yellow)

      }
  }
}
extension View {
  public func halfImageDebugBackground(
    _ url: URL? =
      URL(
        string:
          "https://images.unsplash.com/photo-1770566258012-7d809f99c574?q=80&w=1336&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      ),
    balance: Double = 0.5
  ) -> some View {
    self.modifier(
      HalfImageBackgroundModifier(
        url: url,
        balanceFactor: balance
      )
    )
  }
}
// MARK: - Numeric helpers

public enum NumericHelpers {
  /// Maps any floating-point value to an integer in 0...9 by:
  /// 1) Clamping the input to 0...1
  /// 2) Scaling by 10 and flooring, then capping at 9 so that 1.0 -> 9
  /// Examples:
  /// - 0.2 -> 2
  /// - 0.9 -> 9
  /// - 2.1 -> 9 (clamped from >1)
  /// - -0.3 -> 0 (clamped from <0)
  @inlinable
  public static func decileIndex(from value: Double) -> Int {
    let clamped = min(max(value, 0.0), 1.0)
    let scaled = Int(floor(clamped * 10.0))
    return min(scaled, 9)
  }

  /// Float overload for convenience
  @inlinable
  public static func decileIndex(from value: Float) -> Int {
    decileIndex(from: Double(value))
  }
}

