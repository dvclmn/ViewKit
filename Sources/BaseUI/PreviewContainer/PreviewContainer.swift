//
//  File.swift
//
//
//  Created by Dave Coleman on 24/7/2024.
//

import SwiftUI

extension PreviewTrait where T == Preview.ViewTraits {
  public static func size(_ width: PreviewWidth, _ height: PreviewHeight = .normal) -> Self {
    .fixedLayout(width: width.value, height: height.value)
  }
}
