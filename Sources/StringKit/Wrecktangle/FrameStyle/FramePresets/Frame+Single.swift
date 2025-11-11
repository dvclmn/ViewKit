//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStructure {

  public static var single: Self {
    Frame {
      Part(.horizontal(.top), weight: .increased)
      Part(.horizontal(.interior))

      Part(.horizontal(.bottom)) { GlyphType.h(.increased) }

      Part(.vertical(.leading)) { GlyphType.v(.increased) }
      Part(.vertical(.interior)) { GlyphType.v(.standard) }
      Part(.vertical(.trailing)) { GlyphType.v(.increased) }

      Part(.join(.leading)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.trailing)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.top)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.bottom)) { GlyphType.join(x: .increased, y: .standard) }
      Part(.join(.cross)) { GlyphType.join(x: .increased, y: .standard) }

      Part(.corner(.topLeading), weight: .increased)
      Part(.corner(.topTrailing), weight: .increased)
      Part(.corner(.bottomLeading), weight: .increased)
      Part(.corner(.bottomTrailing), weight: .increased)

    }
  }
}
