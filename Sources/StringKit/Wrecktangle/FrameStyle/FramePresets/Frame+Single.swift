//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStructure {

  public static var single: Self {
    Frame {
      // MARK: - Horizontal
      Part(.horizontal(.top), weight: .increased)
      Part(.horizontal(.interior))
      Part(.horizontal(.bottom)) { GlyphType.h(.increased) }

      // MARK: - Vertical
      Part(.vertical(.leading)) { GlyphType.v(.increased) }
      Part(.vertical(.interior)) { GlyphType.v(.standard) }
      Part(.vertical(.trailing)) { GlyphType.v(.increased) }

      // MARK: - Joins
      Part(.join(.leading)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.trailing)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.top)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.bottom)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.cross)) { GlyphType.join(x: .increased, y: .standard) }

      // MARK: - Corners
      Part(.corner(.topLeading), weight: .increased)
      Part(.corner(.topTrailing), weight: .increased)
      Part(.corner(.bottomLeading), weight: .increased)
      Part(.corner(.bottomTrailing), weight: .increased)

    }
  }
}
