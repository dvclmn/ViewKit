//
//  TouchesHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import SwiftUI
import CoreTools


@Observable
final class TouchesHandler {
  var phase: InteractionPhase = .none
  
  var active: Stroke?
  var strokes: [Stroke] = []
}
