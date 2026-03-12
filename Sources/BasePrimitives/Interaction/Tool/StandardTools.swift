//
//  StandardTools.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

extension CanvasTool {
//public enum DefaultTools {
  public static let select = CanvasTool(
    kind: .select,
    name: "Select",
    icon: "cursorarrow",
    shortcutKey: "v",
    dragBehavior: .marquee
  )

  public static let pan = CanvasTool(
    kind: .pan,
    name: "Pan",
    icon: "hand.wave",
    shortcutKey: "h",
    dragBehavior: .continuous
  )

  public static let zoom = CanvasTool(
    kind: .zoom,
    name: "Zoom",
    icon: "magnifyingglass",
    shortcutKey: "z",
    dragBehavior: .none
  )
}
