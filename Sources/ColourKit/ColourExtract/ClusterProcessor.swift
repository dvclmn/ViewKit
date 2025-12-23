//
//  ClusterProcessor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/12/2025.
//

import Accelerate
import CoreTools
import Foundation
import SwiftUI

public struct ClusteringResult: Sendable {
  public let colors: [Color]
  public let quantizedImage: CGImage?
}

public enum ClusteringError: Error {
  case imageLoadingFailed
}

internal struct ColorClusteringProcessor {
  let dimension: Int
  let maxIterations: Int

  /// The main entry point for the background thread
  func calculate(
    url: URL,
    k: Int,
    sourceImage: CGImage
  ) async throws -> ClusteringResult {

    // 1. Setup Formats
    var format = Self.createRGBFloatFormat()

    // 2. Load into vImage and Scale
    // We create a buffer at your target 'dimension' (e.g. 256x256)
    //    let destinationSize = vImage_Size(width: dimension, height: dimension)

    // Create an interleaved buffer (RGB)
    let interleavedBuffer = try vImage.PixelBuffer<vImage.InterleavedFx3>(
      cgImage: sourceImage,
      cgImageFormat: &format,
      //      size: destinationSize // vImage handles the scaling here automatically
    )

    /// 3. De-interleave into Planar Buffers
    let planarBuffers = interleavedBuffer.planarBuffers()

    /// 4. Convert Planar Buffers to Swift Arrays
    /// Each buffer.array is an [UnsafeMutableBufferPointer<Float>]
    let redPixels = Array(planarBuffers[0].array)
    let greenPixels = Array(planarBuffers[1].array)
    let bluePixels = Array(planarBuffers[2].array)

    print(
      "Set up RGB pixel arrays: \(redPixels.count), \(greenPixels.count), \(bluePixels.count)"
    )

    /// 2. Initialize Centroids (K-Means++)
    var centroids = initializeCentroids(
      r: redPixels,
      g: greenPixels,
      b: bluePixels,
      k: k
    )

    var assignments = [Int](repeating: 0, count: redPixels.count)

    print("Assignments before any work: \(assignments)")

    /// 3. Main K-Means Loop
    for i in 0..<maxIterations {

      print("Beginning \(i) iteration for K-means loop")
      let previousCentroids = centroids

      /// Step A: Assignment (Find closest centroid for every pixel)
      assignments = assignPixelsToCentroids(
        r: redPixels,
        g: greenPixels,
        b: bluePixels,
        centroids: centroids,
        k: k
      )

      /// Step B: Update (Move centroids to the average of their assigned pixels)
      centroids = updateCentroids(
        r: redPixels, g: greenPixels, b: bluePixels,
        assignments: assignments, k: k
      )

      /// Check for convergence (if centroids stopped moving much)
      if centroidsAreConverged(old: previousCentroids, new: centroids) { break }
    }

    print(
      "K-means loop complete. Final assignments: \(assignments). Number of centroids: \(centroids.count)."
    )

    // 4. Create final UI Color objects
    let finalColors = centroids.map {
      Color(red: Double($0.red), green: Double($0.green), blue: Double($0.blue))
    }

    print("Final colours: \(finalColors.map(\.description))")

    return ClusteringResult(colors: finalColors, quantizedImage: nil)
  }

  // MARK: - Replacing BNNS with vDSP

  private func assignPixelsToCentroids(
    r: [Float],
    g: [Float],
    b: [Float],
    centroids: [Centroid],
    k: Int
  ) -> [Int] {

    print("Beginning process of assigning pixels to centroids")
    let n = r.count
    var closestIndices = [Int](repeating: 0, count: n)
    var minDistances = [Float](repeating: Float.greatestFiniteMagnitude, count: n)

    /// Temporary buffer for distance calculation
    var currentDistances = [Float](repeating: 0, count: n)
    print("Set up currentDistances, about to start work: \(currentDistances)")

    for i in 0..<k {
      guard let c = centroids[safe: i] else {
        print("Index \(i) out of bounds")
        continue
      }

      print("Processing centroid \(i) of \(k)")

      /// Calculate (pixel - centroid)^2 for each channel
      /// This is the lightweight version of previous `distanceSquared` function
      var dr = [Float](repeating: 0, count: n)
      vDSP.add(-c.red, r, result: &dr)
      vDSP.square(dr, result: &dr)

      var dg = [Float](repeating: 0, count: n)
      vDSP.add(-c.green, g, result: &dg)
      vDSP.square(dg, result: &dg)

      var db = [Float](repeating: 0, count: n)
      vDSP.add(-c.blue, b, result: &db)
      vDSP.square(db, result: &db)

      /// Sum channels into currentDistances
      vDSP.add(dr, dg, result: &currentDistances)
      vDSP.add(currentDistances, db, result: &currentDistances)

      /// Update closestIndices if `currentDistances < minDistances`

      for j in 0..<n {
        if currentDistances[j] < minDistances[j] {
          minDistances[j] = currentDistances[j]
          closestIndices[j] = i
        }
      }
    }
    print(
      "Finished assigning pixels to centroids. `currentDistances`: \(currentDistances)")
    return closestIndices
  }
}

extension ColorClusteringProcessor {

  // MARK: - Initialise Centroids
  func initializeCentroids(
    r: [Float],
    g: [Float],
    b: [Float],
    k: Int
  ) -> [Centroid] {

    print("Initializing centroids...")
    var centroids = [Centroid]()
    let pixelCount = r.count

    /// Pick first random centroid
    let randomIndex = Int.random(in: 0..<pixelCount)
    print("Random index chosen: \(randomIndex)")

    centroids.append(
      Centroid(red: r[randomIndex], green: g[randomIndex], blue: b[randomIndex])
    )
    print("Centroids initialized: \(centroids)")

    return centroids
  }

  private func updateCentroids(
    r: [Float],
    g: [Float],
    b: [Float],
    assignments: [Int],
    k: Int
  ) -> [Centroid] {

    print("Updating centroids...")

    /// 1. Create buckets to store the sums and counts for each centroid
    var redSums = [Float](repeating: 0, count: k)
    var greenSums = [Float](repeating: 0, count: k)
    var blueSums = [Float](repeating: 0, count: k)
    var counts = [Float](repeating: 0, count: k)

    /// 2. Single pass: Accumulate values
    /// While this is a loop, Swift's compiler optimizes this heavily.
    for i in 0..<r.count {
      print("Processing pixel \(i) of \(r.count)...")
      let label = assignments[i]
      redSums[label] += r[i]
      greenSums[label] += g[i]
      blueSums[label] += b[i]
      counts[label] += 1
    }

    /// 3. Use vDSP to calculate the new means (Sum / Count)
    /// This replaces the old centroids with new ones
    var newCentroids = [Centroid]()

    for i in 0..<k {
      if counts[i] > 0 {
        newCentroids.append(
          Centroid(
            red: redSums[i] / counts[i],
            green: greenSums[i] / counts[i],
            blue: blueSums[i] / counts[i]
          ))
      } else {
        print("Centroid had no associated pixels. `newCentroids`: \(newCentroids)")
        /// If a centroid has no pixels, keep it as is or re-randomize
        newCentroids.append(Centroid(red: 0, green: 0, blue: 0))
      }
    }

    return newCentroids
  }

  private func centroidsAreConverged(
    old: [Centroid],
    new: [Centroid],
    tolerance: Float = 0.001
  ) -> Bool {
    print("Checking if centroids have converged")
    guard old.count == new.count else {
      print("Number of centroids must match for convergence check")
      return false
    }

    var totalMovement: Float = 0

    for i in 0..<old.count {
      let dr = old[i].red - new[i].red
      let dg = old[i].green - new[i].green
      let db = old[i].blue - new[i].blue

      /// Euclidean distance squared
      totalMovement += (dr * dr + dg * dg + db * db)
    }

    print("Total movement: \(totalMovement)")

    /// If the average movement per centroid is less than our tolerance, we are done
    let hasConverged: Bool = (totalMovement / Float(old.count)) < (tolerance * tolerance)

    print("Have the centroids converged? \(hasConverged)")
    return hasConverged
  }

  static func createRGBFloatFormat() -> vImage_CGImageFormat {
    print("Setting up RGB float format")
    guard
      let format = vImage_CGImageFormat(
        bitsPerComponent: 32,
        bitsPerPixel: 32 * 3,
        colorSpace: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGBitmapInfo(
          rawValue: kCGBitmapByteOrder32Host.rawValue
            | CGBitmapInfo.floatComponents.rawValue | CGImageAlphaInfo.none.rawValue
        )
      )
    else {
      preconditionFailure("vImage_CGImageFormat must have a value.")
    }
    print("RGB float format set up successfully")
    return format

  }
}
