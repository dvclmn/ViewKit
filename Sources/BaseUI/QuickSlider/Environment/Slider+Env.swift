//
//  SliderEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 29/5/2025.
//

import CoreTools
import ViewTools
import SwiftUI

/// These are `QuickSlider` specific, and should replace what was
/// previously handled by `@StyleConfig`.
///
/// It may be that some of these could be useful for inclusion
/// in the global values as well.
extension EnvironmentValues {
  /// The visible pieces of a QuickSlider control.
  @Entry public var sliderComponents: SliderComponents = .all
  /// The reset value used by QuickSlider labels and value context menus.
  @Entry public var sliderDefaultValue: Double?
  /// The supplemental presentation for a stepped QuickSlider.
  @Entry public var stepStyle: StepStyle?
  /// An optional maximum width for the central slider control.
  @Entry public var sliderTrackMaxWidth: CGFloat?
  @Entry var isWithinSliderGroup: Bool = false

}
