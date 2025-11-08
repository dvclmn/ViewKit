//
//  FrameStyleProvider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

//protocol FrameStyleProvider {
//  func part(
//    for type: Box.PartType,
//    position: Box.PositionContext
//  ) -> Box.Part
//}
//
//struct DerivedFrameStyle: FrameStyleProvider {
//  let base: FrameStyleProvider
//  let overrides: [Box.PartType: (Box.PositionContext) -> Box.Part]
//
//  func part(for type: Box.PartType, position: Box.PositionContext) -> Box.Part {
//    guard let custom = overrides[type] else {
//      return base.part(for: type, position: position)
//    }
//    return custom(position)
//  }
//}
