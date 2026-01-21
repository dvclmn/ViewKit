//
//  AnimationTimeline.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 18/11/2024.
//

//import SwiftUI
//
//import BaseUI
//


//struct InteractiveAnimationTimeline: View {
//  
//  @Environment(AppHandler.self) private var store
//  
//  var body: some View {
//    
////    TimelineView(.animation(paused: timeline.isPaused)) { context in
//      
//    let timelineDate: Date = isPreview ? .now : .now
//      
//      VSplitView {
//        
//        Text("Hello")
//          .padding(40)
//          .frame(maxWidth: .infinity)
//        
//        VStack(spacing: 0) {
//          TimelineControls()
//          TimelineRuler()
//            .gesture(dragGesture)
//        }
//        .frame(
//          maxWidth: .infinity,
//          minHeight: 200
//        )
//        .background(.black.opacity(0.5))
//        
//        .task(id: timelineDate) {
//          if !store.timeline.isPaused {
//            store.timeline.currentTime += 1/60
//          }
//        }
//      }
////    } // END timeline view
//    
//    
//    
//    
//  }
//}
//
//extension InteractiveAnimationTimeline {
//  
//  var dragGesture: some Gesture {
//    DragGesture(minimumDistance: 1)
//      .onChanged { drag in
//        store.timeline.currentTime = drag.location.x
//      }
//      .onEnded { drag in
//        
//      }
//  }
//  
//  @ViewBuilder
//  func TimelineControls() -> some View {
//    @Bindable var store = store
//    
//    HStack {
//      
//      
//      Text("\(store.timeline.currentTime)")
////      Text("\(store.timeline.currentTime.padLeading(maxDigits: 2, decimalPlaces: 2))")
//        .font(.title3)
//        .fontDesign(.rounded)
//        .monospacedDigit()
//        .padding(.horizontal, Styles.sizeSmall.bump)
//        .padding(.vertical, Styles.sizeSmall)
//        .background {
//          RoundedRectangle(cornerRadius: Styles.sizeSmall)
//            .fill(.regularMaterial)
//        }
//      
//      Button(action: { store.timeline.isPaused.toggle() }) {
//        Image(systemName: store.timeline.isPaused ? "play.fill" : "pause.fill")
//      }
//      
//      Button(action: { store.timeline.currentTime = 0 }) {
//        Image(systemName: "backward.end.fill")
//      }
//      
//      
//      HStack {
//        Text("Zoom: \(String(format: "%.1f", store.timeline.zoom))s")
//        Slider(value: $store.timeline.zoom, in: 1...30)
//      }
//      .padding(.horizontal)
//      
//      
//     
//    }
//    .padding(Styles.sizeSmall)
//    .background(.black.opacity(0.3))
//    
//  }
//}
//
//struct TimelineRuler: View {
//  
//  @Environment(AppHandler.self) private var store
//  
//  private let majorTickHeight: CGFloat = 20
//  private let minorTickHeight: CGFloat = 10
//  
//  var body: some View {
//    
//    
//    
//    Canvas { context, size in
//
//      /// Calculate tick spacing
//      let pixelsPerSecond = size.width / store.timeline.zoom
//      let majorTickInterval = calculateMajorTickInterval(for: store.timeline.zoom)
//      
//      // Draw ticks and labels
//      for second in 0...Int(ceil(store.timeline.zoom)) {
//        let x = CGFloat(second) * pixelsPerSecond
//        
//        if second % majorTickInterval == 0 {
//          // Draw major tick
//          drawTick(context: context, at: x, height: majorTickHeight)
//          
//          // Draw label
//          let text = Text("\(second)s")
//            .font(.caption)
//          context.draw(text, at: CGPoint(x: x, y: 10))
//        } else {
//          // Draw minor tick
//          drawTick(context: context, at: x, height: minorTickHeight)
//        }
//      }
//      
//      // Draw playhead
//      let playheadX = (store.timeline.currentTime.truncatingRemainder(dividingBy: store.timeline.zoom)) * pixelsPerSecond
//      let playheadPath = Path { path in
//        path.move(to: CGPoint(x: playheadX, y: 0))
//        path.addLine(to: CGPoint(x: playheadX, y: size.height))
//      }
//      context.stroke(playheadPath, with: .color(.red), lineWidth: 2)
//    } // END canvas
//  }
//  
//  private func calculateMajorTickInterval(for zoom: Double) -> Int {
//    if zoom <= 5 { return 1 }
//    if zoom <= 10 { return 2 }
//    if zoom <= 20 { return 5 }
//    return 10
//  }
//  
//  private func drawTick(context: GraphicsContext, at x: CGFloat, height: CGFloat) {
//    let tickPath = Path { path in
//      path.move(to: CGPoint(x: x, y: height))
//      path.addLine(to: CGPoint(x: x, y: height * 2))
//    }
//    context.stroke(tickPath, with: .color(.secondary), lineWidth: 1)
//  }
//}
//
//
//
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .grainient) {
//  InteractiveAnimationTimeline()
//}
//#endif
//
