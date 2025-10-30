//
//  Headers+Footers.swift
//  Helpers
//
//  Created by Dave Coleman on 22/8/2024.
//

extension BoxCore {

  public static func header(_ info: String) -> String {
    return """

      \(headerExteriorLine)
      \(info)
      \(headerInteriorLine)
      """
  }

  public static let headerExteriorLine: String = "=============================================================="
  public static let headerInteriorLine: String = "--------------------------------------------------------------"
  public static let footerLine: String = "◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡◠◡"

  public static let footerLineAlt: String = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

}
