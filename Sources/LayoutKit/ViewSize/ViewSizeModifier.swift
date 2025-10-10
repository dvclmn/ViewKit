//
//  ViewSizeModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/5/2025.
//

import SharedHelpers
import SwiftUI

public typealias ViewSizeOutput<T> = (T) -> Void

public struct ViewSizeModifier<Capture: GeometryCapturable>: ViewModifier {

  @State private var debouncer: AsyncDebouncer?
  //  @State private var newCapture: Capture?

  let capture: GeometryCapture<Capture>
  let valueOutput: ViewSizeOutput<Capture>

  // MARK: - Initialiser
  public init(
    capture: GeometryCapture<Capture>,
    mode: DebounceMode,
    valueOutput: @escaping ViewSizeOutput<Capture>
  ) {
    switch mode {
      case .debounce(let interval):
        self._debouncer = State(initialValue: AsyncDebouncer(interval: interval))
      case .noDebounce:
        self._debouncer = State(initialValue: nil)

    //      case .byo(let existingDebouncer):
    //        self._debouncer = State(initialValue: existingDebouncer)
    }
    self.capture = capture
    self.valueOutput = valueOutput
  }

  // MARK: - View Modifier
  public func body(content: Content) -> some View {
    
    content
      .onGeometryChange(for: capture.type) { proxy in
        return capture.transform(proxy)

      } action: { newValue in
        //        updateIfChanged(&newCapture, to: newValue)

        Task {
          if let debouncer {
            await debouncer.execute { @MainActor in
              valueOutput(newValue)
            }
          } else {
            valueOutput(newValue)
          }
        }
      }

    //      .onAppear {
    //        sleepyTask(interval: 0.4) { @MainActor in
    //          if let newCapture {
    //            valueOutput(newCapture)
    //          }
    //        }
    //
    //      }
  }
}

// MARK: - View Extension
extension View {
  /// Previously had default value for `debounceMode`, but this felt
  /// too risky for domains that may be tripped up by immediate vs debounced
  public func viewSize<T: GeometryCapturable>(
    capture: GeometryCapture<T> = .size,
    mode debounceMode: DebounceMode,
    valueOutput: @escaping ViewSizeOutput<T>,
  ) -> some View {
    self.modifier(
      ViewSizeModifier(
        capture: capture,
        mode: debounceMode,
        valueOutput: valueOutput
      )
    )
  }
}
