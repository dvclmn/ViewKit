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
//              print("Geometry change with debouncing.")
              valueOutput(newValue)
            }
          } else {
//            print("Geometry change, *no* debouncing.")
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
