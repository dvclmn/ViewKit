//
//  SimpleWave+ContentView.swift
//  BaseDemos
//
//  Created by Dave Coleman on 29/1/2026.
//

import MotionKit
import SwiftUI
import ToolKit

struct SimpleWave_ContentView: View {
  @Environment(\.isInspectorPresented) private var isInspectorPresented
  @Environment(SimpleWaveHandler.self) private var store

  //  init(store: SimpleWaveHandler? = nil) {
  //    self._store = State(initialValue: store ?? .init())
  //  }
  var body: some View {

    @Bindable var store = store

    AnimationTimeline { time in
      Text("Not in use, complex is fixed")
//      SimpleWaveCanvas(store: store)
//        .task(id: time) {
//          store.waveState.update(
//            at: time, frequency: store.wave.frequency)
//        }
    }
    .background(.black.secondary)
    .drawingGroup(opaque: true)

    .inspector(isPresented: isInspectorPresented) {
      SimpleWaveInspector()
    }
  }
}
enum CanvasSymbol {
  static let dot: String = "dot"
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = SimpleWaveHandler()
  @Previewable @State var frameRate: FrameRate = .fps15
  SimpleWave_ContentView()
    .environment(store)
    //        .environment(\.isPaused, .constant(false))
    .environment(\.frameRate, $frameRate)
//    .environment(\.simpleHandler, store)
    .environment(\.isInspectorPresented, .constant(true))
//    .onAppear {
//      store.waveGenerator.usesAltCubicMethod = false
//      store.waveGenerator = .catmullRom(.chordal)
      //      store.wave.wave.amplitude = 140
      //      store.wave.config.cycles = 10
//    }
}
#endif
