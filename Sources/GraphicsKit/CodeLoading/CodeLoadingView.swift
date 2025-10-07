//
//  CodeLoading.swift
//  Components
//
//  Created by Dave Coleman on 21/11/2024.
//

//import BaseComponents
import BaseHelpers
import SwiftUI

public struct CodeLoadingView: View {

//  @State private var randomGenerator = RandomValueGenerator<Double>(seed: 12345)
  @State private var randomValues: [String: Double] = [:]

  public var config: CodeLoadingConfiguration

  public init(config: CodeLoadingConfiguration = .init()) {
    self.config = config
  }

  public var body: some View {

    Canvas { context, size in

      var currentLine = 0

      for objectIndex in 0..<config.objectCount {
        currentLine = drawCodeBlock(
          context,
          size: size,
          startLine: currentLine,
          depth: 0
        )

        if objectIndex < config.objectCount - 1 {
          currentLine += 1
        }
      }
    }  // END Canvas
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

    .task(id: config) {
      precomputeRandomValues()
    }
  }
}

extension CodeLoadingView {
  
  // When the view initializes or config changes, pre-compute all random values
  func precomputeRandomValues() {
    var generator = SeededGenerator(seed: config.seed)
    
    // Clear existing values
    randomValues = [:]
    
    // Estimate how many random values we'll need
    let totalLines = estimateTotalLines()
    
    // Generate all the random values we'll need
    for lineIndex in 0..<totalLines {
      for segmentIndex in 0..<50 { // Use a reasonable maximum number of segments
        let key = "line_\(lineIndex)_segment_\(segmentIndex)"
        randomValues[key] = Double.random(in: config.word.lengthRange, using: &generator)
      }
    }
  }
  
  // Helper to estimate total lines (adjust based on your config)
  private func estimateTotalLines() -> Int {
    // Simple estimation based on config
    return config.objectCount * 10 // Adjust based on your actual needs
  }
  

  private func drawCodeBlock(
    _ context: GraphicsContext,
    size: CGSize,
    startLine: Int,
    depth: Int
  ) -> Int {

    var currentLine = startLine
    let block = CodeBlock.generate(at: depth, maxDepth: config.nestingDepth)

    /// Draw declaration
    drawLine(
      context,
      size: size,
      part: .declaration,
      lineIndex: currentLine,
      indentLevel: depth
    )
    currentLine += 1

    /// Draw properties
    for _ in 0..<block.properties {
      drawLine(
        context,
        size: size,
        part: .content,
        lineIndex: currentLine,
        indentLevel: depth
      )
      currentLine += 1
    }

    /// Draw nested block if needed
    if block.hasNestedBlock {
      currentLine = drawCodeBlock(
        context,
        size: size,
        startLine: currentLine,
        depth: depth + 1
      )
    }

    /// Draw closing brace
    drawLine(
      context,
      size: size,
      part: .closingBrace,
      lineIndex: currentLine,
      indentLevel: depth
    )
    return currentLine + 1
  }

  // MARK: - Draw Line
  private func drawLine(
    _ context: GraphicsContext,
    size: CGSize,
    part: CodePart,
    lineIndex: Int,
    indentLevel: Int
  ) {

    let yPosition = (config.word.height + config.word.lineHeight) * Double(lineIndex)
    let indentation = Double(indentLevel) * config.indentationWidth

    /// Available width for content
    let availableWidth = max(0, size.width - indentation)

    /// Calculate content width based on part type
    let contentWidth: Double = part.width(within: availableWidth, range: config.contentWidthRange)

    /// Ensure we have minimum width to draw
    guard contentWidth >= config.word.lengthRange.lowerBound else { return }

    /// Calculate number of segments
    let avgSegmentWidth = config.word.lengthRange.upperBound * 0.7
    let spacing = config.spaceWidth * config.spaceFrequency.rawValue
    let approximateSegments = max(1, Int(contentWidth / (avgSegmentWidth + spacing)))

    var currentX = indentation
    let endX = indentation + contentWidth

    /// Draw segments
    for segmentIndex in 0..<approximateSegments {

      let isLastSegment = segmentIndex == approximateSegments - 1
      let remainingWidth = endX - currentX
      
      
      // Use pre-computed random value - no mutation during drawing
      let cacheKey = "line_\(lineIndex)_segment_\(segmentIndex)"
      let randomValue = randomValues[cacheKey] ?? config.word.lengthRange.lowerBound
      
      let segmentWidth: Double
      if isLastSegment {
        segmentWidth = min(remainingWidth, randomValue)
      } else {
        segmentWidth = min(
          randomValue,
          remainingWidth / Double(approximateSegments - segmentIndex)
        )
      }
      
      

//      /// Calculate segment width
//      let segmentWidth: Double
//      if isLastSegment {
//        segmentWidth = min(
//          remainingWidth,
//          randomGenerator.generate(
//            count: 1,
//            parameters: RandomisationParameters(ranges: [config.word.lengthRange]),
//            cacheKey: "line_\(lineIndex)_segment_\(segmentIndex)"
//          )
//        )
//      } else {
//        segmentWidth = min(
//          randomGenerator.generate(
//            count: 1,
//            parameters: RandomisationParameters(ranges: [config.word.lengthRange]),
//            cacheKey: "line_\(lineIndex)_segment_\(segmentIndex)"
//          ),
//          remainingWidth / Double(approximateSegments - segmentIndex)
//        )
//      }

      if segmentWidth > 0 && currentX + segmentWidth <= size.width {
        let rect = CGRect(
          x: currentX,
          y: yPosition,
          width: segmentWidth,
          height: config.word.height
        )
        let roundedRect = Path(roundedRect: rect, cornerRadius: config.word.rounding)

        context.fill(roundedRect, with: .color(config.word.type.swatch.swiftUIColour))
      }

      currentX += segmentWidth + spacing
    }
  }
}

#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .grainient(.narrow)) {
  CodeLoadingView()
    .padding()
}
#endif
