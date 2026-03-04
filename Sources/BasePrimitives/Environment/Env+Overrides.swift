//
//  Env+Overrides.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import SwiftUI

extension EnvironmentValues {

  /// As opposed to the more *specific* naming such as icon{x},
  /// stroke{x}, these override{x} properties can be applied to anything.
  @Entry public var sizeOverride: CGSize?
  @Entry public var heightOverride: CGFloat?
  @Entry public var widthOverride: CGFloat?
  @Entry public var fontSizeOverride: CGFloat?
  @Entry public var fontWeightOverride: Font.Weight?
  
  /// `length` useful when referring to neither height nor width specifically
  @Entry public var lengthOverride: CGFloat?
  @Entry public var rangeOverride: ClosedRange<CGFloat>?
  
  /// Helpful article on `aspectRatio`
  /// https://alejandromp.com/development/blog/image-aspectratio-without-frames/
  /// See also `viewAspectRatio()` in BaseHelpers
  @Entry public var aspectRatioOverride: CGFloat?
  @Entry public var contentModeOverride: ContentMode?
  @Entry public var controlSizeOverride: ControlSize?

  /// Perhaps the below two can be merged.
  @Entry public var shapeStyleOverride: AnyShapeStyle?
  @Entry public var colourOverride: Color?
}
