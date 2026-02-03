//
//  ViewSizeModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/5/2025.
//

import CoreTools
import SwiftUI

public typealias ViewSizeOutput<T> = (T) -> Void

public struct ViewSizeModifier<Capture: GeometryCapturable>: ViewModifier {

  @State private var debouncer: AsyncDebouncer?

  let capture: GeometryCapture<Capture>
  let isEnabled: Bool
  let valueOutput: ViewSizeOutput<Capture>

  // MARK: - Initialiser
  public init(
    capture: GeometryCapture<Capture>,
    mode: DebounceMode,
    isEnabled: Bool,
    valueOutput: @escaping ViewSizeOutput<Capture>
  ) {
    self._debouncer = mode.createDebouncer()
    self.capture = capture
    self.isEnabled = isEnabled
    self.valueOutput = valueOutput
  }

  // MARK: - View Modifier
  public func body(content: Content) -> some View {
    content
      .onGeometryChange(for: capture.type) { proxy in
        capture.transform(proxy)

      } action: { newValue in
        guard isEnabled else { return }

        if let debouncer {
          debouncer.execute { @MainActor in
            valueOutput(newValue)
          }
        } else {
          valueOutput(newValue)
        }
      }
  }
}
