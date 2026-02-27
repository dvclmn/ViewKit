//
//  PanMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

public enum ViewAnchor {
  /// Trying to express; SwiftUI anchors my View to the centre by default,
  /// calculations must take that into account
  case anchoredToCentre
}

public enum PanSpace {
  /// Pan is expressed in global/screen points (already scaled)
  case global
  /// Pan is expressed in local/canvas points (independent of zoom)
  case local
}
