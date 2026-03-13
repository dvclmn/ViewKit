//
//  StandardTools.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

extension CanvasTool {
  public static let defaultTools: [CanvasTool] = [.select, .pan, .zoom]

  public static let select = CanvasTool(
    kind: .select,
    name: "Select",
    icon: "cursorarrow",
    dragBehavior: .marquee
  )

  public static let pan = CanvasTool(
    kind: .pan,
    name: "Pan",
    icon: "hand.wave",
    dragBehavior: .continuous
  )

  public static let zoom = CanvasTool(
    kind: .zoom,
    name: "Zoom",
    icon: "magnifyingglass",
    dragBehavior: .none
  )
}
