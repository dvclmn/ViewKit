//
//  StructureLine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

//extension Box {
//  
//  public struct StructureLine: Codable, Sendable {
//    public let leading: Box.PartType
//    public let body: Box.PartType
//    public let trailing: Box.PartType
//    
//    public init(
//      leading: Box.PartType,
//      body: Box.PartType,
//      trailing: Box.PartType
//    ) {
//      self.leading = leading
//      self.body = body
//      self.trailing = trailing
//    }
//  }
//}
extension Box.LineType {
  
//  func buildStructure(
//    width: Int,
//    theme: Box.Theme
//  ) -> StringStack {
//    StringStack.joined(
//      leading.buildStack(toWidth: width, using: theme),
//      body.buildStack(toWidth: width, using: theme),
//      trailing.buildStack(toWidth: width, using: theme),
//      along: .horizontal
//    )
//  }
  
//  static func structure(
//    width: Int,
//    for type: Box.StructureType,
//    with theme: Box.Theme
//  ) -> StringStack {
//    switch type {
//      case .top:
//        
//        Box.StructureLine(
//          leading: .corner(.topLeading),
//          body: .horizontal(.top),
//          trailing: .corner(.topTrailing)
//        ).build(width: width, theme: theme)
//        
//      case .divider:
//        Box.StructureLine(
//          leading: .vertical(.leading),
//          body: .horizontal(.interior),
//          trailing: .vertical(.trailing),
//        ).build(width: width, theme: theme)
//        
//      case .bottom:
//        Box.StructureLine(
//          leading: .corner(.bottomLeading),
//          body: .horizontal(.bottom),
//          trailing: .corner(.bottomTrailing)
//        ).build(width: width, theme: theme)
//    }
//  }
}
