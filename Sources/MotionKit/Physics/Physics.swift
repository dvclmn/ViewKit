////
////  File.swift
////
////
////  Created by Dave Coleman on 25/7/2024.
////
//
//import SwiftUI
//
//
//public struct BouncingItemsView: View {
//  let itemCount: Int
//  let color: Color
//  
//  public init(
//    itemCount: Int,
//    color: Color
//  ) {
//    self.itemCount = itemCount
//    self.color = color
//  }
//  
//  public var body: some View {
//    GeometryReader { geometry in
//      PhysicsItemView(
//        itemCount: itemCount,
//        containerSize: geometry.size
//      )
//      .frame(width: geometry.size.width, height: geometry.size.height)
//    }
//    .frame(height: 200)  // Adjust this value as needed
//  }
//}
//
//struct PhysicsItemView: View {
//  let itemCount: Int
//  let containerSize: CGSize
//  
//  @State private var items: [PhysicsItem] = []
//  @State private var timer: Timer?
//  
//  let itemSize: CGFloat = 60
//  let gravity: CGFloat = 0.4
//  let damping: CGFloat = 0.9
//  let collisionElasticity: CGFloat = 0.9
//  
//  var body: some View {
//    GeometryReader { geometry in
//      ZStack {
//        ForEach(items) { item in
//          Circle()
//            .fill(Color.blue)
//            .frame(width: itemSize, height: itemSize)
//            .position(item.position)
//        }
//      }
//      .onAppear {
//        initializeItems(in: geometry.size)
//        startPhysicsSimulation()
//      }
//      .onDisappear {
//        timer?.invalidate()
//      }
//    }
//  }
//  
//  private func initializeItems(in size: CGSize) {
//    items = (0..<itemCount).map { _ in
//      PhysicsItem(
//        position: CGPoint(
//          x: CGFloat.random(in: itemSize/2...size.width-itemSize/2),
//          y: CGFloat.random(in: itemSize/2...size.height/3)
//        ),
//        velocity: CGVector(
//          dx: CGFloat.random(in: -5...5),
//          dy: CGFloat.random(in: -2...2)
//        )
//      )
//    }
//  }
//  
//  private func startPhysicsSimulation() {
//    timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
//      updatePhysics()
//    }
//  }
//  
//  private func updatePhysics() {
//    var updatedItems = items // Create a mutable copy
//    
//    // Apply physics to each item
//    for i in 0..<updatedItems.count {
//      applyPhysics(to: &updatedItems[i])
//    }
//    
//    // Check for collisions and resolve them
//    for i in 0..<updatedItems.count {
//      for j in (i+1)..<updatedItems.count {
//        if checkCollision(between: updatedItems[i], and: updatedItems[j]) {
//          let (newVelocity1, newVelocity2) = resolveCollision(between: updatedItems[i], and: updatedItems[j])
//          updatedItems[i].velocity = newVelocity1
//          updatedItems[j].velocity = newVelocity2
//        }
//      }
//    }
//    
//    // Update the state
//    items = updatedItems
//  }
//  
//  private func resolveCollision(between item1: PhysicsItem, and item2: PhysicsItem) -> (CGVector, CGVector) {
//    let normal = CGVector(dx: item2.position.x - item1.position.x, dy: item2.position.y - item1.position.y)
//    let distance = sqrt(normal.dx * normal.dx + normal.dy * normal.dy)
//    let unitNormal = CGVector(dx: normal.dx / distance, dy: normal.dy / distance)
//    
//    let relativeVelocity = CGVector(
//      dx: item2.velocity.dx - item1.velocity.dx,
//      dy: item2.velocity.dy - item1.velocity.dy
//    )
//    
//    let velocityAlongNormal = relativeVelocity.dx * unitNormal.dx + relativeVelocity.dy * unitNormal.dy
//    
//    if velocityAlongNormal > 0 { return (item1.velocity, item2.velocity) }
//    
//    let impulseStrength = -(1 + collisionElasticity) * velocityAlongNormal
//    let impulse = CGVector(dx: impulseStrength * unitNormal.dx, dy: impulseStrength * unitNormal.dy)
//    
//    let newVelocity1 = CGVector(dx: item1.velocity.dx - impulse.dx, dy: item1.velocity.dy - impulse.dy)
//    let newVelocity2 = CGVector(dx: item2.velocity.dx + impulse.dx, dy: item2.velocity.dy + impulse.dy)
//    
//    return (newVelocity1, newVelocity2)
//  }
//  
//  private func applyPhysics(to item: inout PhysicsItem) {
//    // Apply gravity
//    item.velocity.dy += gravity
//    
//    // Update position
//    item.position.x += item.velocity.dx
//    item.position.y += item.velocity.dy
//    
//    // Bounce off walls
//    if item.position.x - itemSize/2 < 0 || item.position.x + itemSize/2 > containerSize.width {
//      item.velocity.dx *= -collisionElasticity
//      item.position.x = max(itemSize/2, min(containerSize.width - itemSize/2, item.position.x))
//    }
//    
//    if item.position.y - itemSize/2 < 0 || item.position.y + itemSize/2 > containerSize.height {
//      item.velocity.dy *= -collisionElasticity
//      item.position.y = max(itemSize/2, min(containerSize.height - itemSize/2, item.position.y))
//    }
//    
//    // Apply damping
//    item.velocity.dx *= damping
//    item.velocity.dy *= damping
//  }
//  
//  private func checkCollision(between item1: PhysicsItem, and item2: PhysicsItem) -> Bool {
//    let distance = sqrt(pow(item1.position.x - item2.position.x, 2) + pow(item1.position.y - item2.position.y, 2))
//    return distance < itemSize
//  }
//  
//}
//
//
//struct PhysicsItem: Identifiable {
//  let id = UUID()
//  var position: CGPoint
//  var velocity: CGVector
//}
//
