//
//  Line+StructureType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

extension Box {
  public typealias ThreePartPreset = (
    leading: Box.PartType,
    repeater: Box.PartType,
    trailing: Box.PartType
  )
  
  public enum StructureType: String, Hashable, Sendable {
    case top
    case divider
    case bottom
    case blank
  }
}

extension Box.StructureType {
  var parts: Box.ThreePartPreset {
    switch self {
        
      case .top:
        
        (
          .corner(.topLeading),
          .horizontal(.top),
          .corner(.topTrailing),
        )
        
      case .divider:
        
        (
          .join(.leading),
          .horizontal(.interior),
          .join(.trailing),
        )
        
      case .bottom:
        
        (
          .corner(.bottomLeading),
          .horizontal(.bottom),
          .corner(.bottomTrailing),
        )
        
      case .blank:
        
        (
          .vertical(.leading),
          .blank,
          .vertical(.trailing),
        )
        
        //      case .top:
        //        Box.StructureLine(
        //          .corner(.topLeading),
        //          .horizontal(.top),
        //          .corner(.topTrailing),
        //        )
        //
        //      case .divider:
        //        Box.StructureLine(
        //          .join(.leading),
        //          .horizontal(.interior),
        //          .join(.trailing),
        //        )
        //
        //      case .bottom:
        //        Box.StructureLine(
        //          .corner(.bottomLeading),
        //          .horizontal(.bottom),
        //          .corner(.bottomTrailing),
        //        )
        //
        //      case .blank:
        //        Box.StructureLine(
        //          .vertical(.leading),
        //          .blank,
        //          .vertical(.trailing),
        //        )
        //    }
    }
  }
}
