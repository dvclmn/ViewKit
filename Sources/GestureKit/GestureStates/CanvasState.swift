//
//  CanvasState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

struct CanvasState {
  var transform: CanvasTransform
  
  var activeMarquee: CGRect?
  var selection: Set<ItemID>
}

//public protocol CanvasState {
//  var zoom: CGFloat { get set }
//  var pan: CGSize { get set }
//  var rotation: Angle { get set }
//  
//  var tapLocation: CGPoint? { get set }
//  var hoverLocation: CGPoint? { get set }
//}
