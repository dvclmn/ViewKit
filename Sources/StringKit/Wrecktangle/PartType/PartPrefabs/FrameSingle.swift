//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {
  //extension Box.FrameStyle {

  /// This is effectively a *conversion*, from a
  /// `PartType` to a `GlyphType`.
  ///
  /// A single-glyph Frame is quite simple, as we don't have
  /// to consider orientation, for top/bottom, or left/right.
  /// It's just the same glyph.
  ///
  /// Perhaps, in future, I will add the concept of per-axis
  /// glyph styles, but for now, these Frames have the
  /// *same glyph style* for all axes.
  func singleFrame(
    frameProm: Box.GlyphProminence,
    divProm: Box.GlyphProminence,
    //    with prominence: Box.GlyphProminence,
  ) -> Box.GlyphStack {

    let type: Box.GlyphType? =
      switch self {

        case .horizontal(.top), .horizontal(.bottom):
          Box.GlyphType.horizontal(frameProm)

        case .horizontal(.interior):
          Box.GlyphType.horizontal(divProm)

        case .vertical(.leading), .vertical(.trailing):
          Box.GlyphType.vertical(frameProm)

        case .vertical(.interior):
          Box.GlyphType.vertical(divProm)

        case .join(let joinType):
          switch joinType {
            case .leading, .trailing:
              Box.GlyphType.join(
                x: divProm,
                y: frameProm,
                type: joinType
              )

            case .top, .bottom:
              Box.GlyphType.join(
                x: frameProm,
                y: divProm,
                type: joinType
              )

            case .cross:
              Box.GlyphType.join(
                x: divProm,
                y: divProm,
                type: joinType
              )
          }

        case .corner(let cornerType):
//          switch cornerType {
//            case .topLeading:
//              Box.GlyphType.corner(frameProm, type: .topLeading)
//            case .topTrailing:
//              <#code#>
//            case .bottomLeading:
//              <#code#>
//            case .bottomTrailing:
//              <#code#>
//          }
          Box.GlyphType.corner(frameProm, type: cornerType)

//        case .text:
//          nil

        case .blank:
          Box.GlyphType.blank

      }  // END switch self

    guard let type else { return [[]] }
    return [[type]]
  }
}
