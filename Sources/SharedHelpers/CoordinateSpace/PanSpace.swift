//
//  PanMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

public enum PanSpace {
  /// Pan is expressed in global/screen points (already scaled)
  case global
  /// Pan is expressed in local/canvas points (independent of zoom)
  case local
}
