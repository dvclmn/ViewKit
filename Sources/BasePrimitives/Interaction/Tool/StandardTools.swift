//
//  StandardTools.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

public enum DefaultTools {
  public static let select = CanvasTool(
    //    id: "select",
    name: "Select",
    icon: "cursorarrow",
    shortcutKey: "v",
    //    behaviours: [],
    dragBehavior: .marquee
  )

  public static let pan = CanvasTool(
    //    id: "pan",
    name: "Pan",
    icon: "hand.wave",
    shortcutKey: "h",
    //    behaviours: [],
    dragBehavior: .continuous
  )

  public static let zoom = CanvasTool(
    //    id: "zoom",
    name: "Zoom",
    icon: "magnifyingglass",
    shortcutKey: "z",
    //    behaviours: [
    //      ToolBehaviour(
    //        trigger: .modifierKey(.command),
    //        springLoadTarget: .select, // see note below on decoupling this
    //        description: "Hold Command to temporarily select"
    //      )
    //    ],
    dragBehavior: .none
  )
}
