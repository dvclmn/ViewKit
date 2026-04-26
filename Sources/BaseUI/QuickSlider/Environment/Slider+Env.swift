//
//  SliderEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 29/5/2025.
//

import BasePrimitives
import SwiftUI

/// These are `QuickSlider` specific, and should replace what was
/// previously handled by `@StyleConfig`.
///
/// It may be that some of these could be useful for inclusion
/// in the global values as well.
extension EnvironmentValues {
  @Entry public var sliderComponents: SliderComponents = .all
  @Entry public var sliderDefaultValue: Double?
  @Entry public var sliderTrackStyle: (any SliderTrackStyle)?
  @Entry public var stepStyle: StepStyle?
  @Entry public var sliderTrackMaxWidth: CGFloat?
  @Entry var isWithinSliderGroup: Bool = false

}
