//
//  ClusterProcessor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/12/2025.
//

import Accelerate
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
  func calculate(url: URL, k: Int) async throws -> ClusteringResult {

    //    /// 1. Load Image and Get Planar Buffers (Red, Green, Blue)
    //    /// Use vImage to scale the image to the working 'dimension' (e.g., 256x256)
    //    guard let source = ThumbnailGenerator.cgImageFromURL(url) else {
    //      throw ClusteringError.imageLoadingFailed
    //    }

    guard let sourceCGImage = ThumbnailGenerator.cgImageFromURL(url) else {
      throw ClusteringError.imageLoadingFailed
    }

    // 1. Setup Formats
    var format = Self.createRGBFloatFormat()

    // 2. Load into vImage and Scale
    // We create a buffer at your target 'dimension' (e.g. 256x256)
    //    let destinationSize = vImage_Size(width: dimension, height: dimension)

    // Create an interleaved buffer (RGB)
    let interleavedBuffer = try vImage.PixelBuffer<vImage.InterleavedFx3>(
      cgImage: sourceCGImage,
      cgImageFormat: &format,
      //      size: destinationSize // vImage handles the scaling here automatically
    )

    // 3. De-interleave into Planar Buffers
    let planarBuffers = interleavedBuffer.planarBuffers()

    // 4. Convert Planar Buffers to Swift Arrays
    // Each buffer.array is an [UnsafeMutableBufferPointer<Float>]
    let redPixels = Array(planarBuffers[0].array)
    let greenPixels = Array(planarBuffers[1].array)
    let bluePixels = Array(planarBuffers[2].array)

    // ... (Logic to fill these arrays via vImage scale would go here)

    /// 2. Initialize Centroids (K-Means++)
    var centroids = initializeCentroids(r: redPixels, g: greenPixels, b: bluePixels, k: k)
    var assignments = [Int](repeating: 0, count: pixelCount)

    /// 3. Main K-Means Loop
    for _ in 0..<maxIterations {
      let previousCentroids = centroids

      /// Step A: Assignment (Find closest centroid for every pixel)
      assignments = assignPixelsToCentroids(
        r: redPixels, g: greenPixels, b: bluePixels,
        centroids: centroids, k: k
      )

      /// Step B: Update (Move centroids to the average of their assigned pixels)
      centroids = updateCentroids(
        r: redPixels, g: greenPixels, b: bluePixels,
        assignments: assignments, k: k
      )

      /// Check for convergence (if centroids stopped moving much)
      if centroidsAreConverged(old: previousCentroids, new: centroids) { break }
    }

    // 4. Create final UI Color objects
    let finalColors = centroids.map {
      Color(red: Double($0.red), green: Double($0.green), blue: Double($0.blue))
    }

    return ClusteringResult(colors: finalColors, quantizedImage: nil)
  }

  // MARK: - Replacing BNNS with vDSP

  private func assignPixelsToCentroids(
    r: [Float], g: [Float], b: [Float], centroids: [Centroid], k: Int
  ) -> [Int] {
    let n = r.count
    var closestIndices = [Int](repeating: 0, count: n)
    var minDistances = [Float](repeating: Float.greatestFiniteMagnitude, count: n)

    // Temporary buffer for distance calculation
    var currentDistances = [Float](repeating: 0, count: n)

    for i in 0..<k {
      let c = centroids[i]

      // Calculate (pixel - centroid)^2 for each channel
      // This is the "Lightweight" version of your distanceSquared function
      var dr = [Float](repeating: 0, count: n)
      vDSP.add(-c.red, r, result: &dr)
      vDSP.square(dr, result: &dr)

      var dg = [Float](repeating: 0, count: n)
      vDSP.add(-c.green, g, result: &dg)
      vDSP.square(dg, result: &dg)

      var db = [Float](repeating: 0, count: n)
      vDSP.add(-c.blue, b, result: &db)
      vDSP.square(db, result: &db)

      // Sum channels into currentDistances
      vDSP.add(dr, dg, result: &currentDistances)
      vDSP.add(currentDistances, db, result: &currentDistances)

      // Update closestIndices if currentDistances < minDistances
      for j in 0..<n {
        if currentDistances[j] < minDistances[j] {
          minDistances[j] = currentDistances[j]
          closestIndices[j] = i
        }
      }
    }
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
    //    self.centroids.removeAll()
    var centroids = [Centroid]()
    let pixelCount = r.count

    //    let randomIndex = Int.random(in: 0..<dimension * dimension)
    //    centroids.append(
    //      Centroid(
    //        red: storage.redStorage[randomIndex],
    //        green: storage.greenStorage[randomIndex],
    //        blue: storage.blueStorage[randomIndex])
    //    )
    //
    // Pick first random centroid
    let randomIndex = Int.random(in: 0..<pixelCount)
    centroids.append(
      Centroid(red: r[randomIndex], green: g[randomIndex], blue: b[randomIndex]))

    // Use the first row of the `distances` buffer as temporary storage.
    //    let tmp = UnsafeMutableBufferPointer(
    //      start: distances?.baseAddress,
    //      count: dimension * dimension
    //    )
    //
    //    /// For a simple optically pleasing result, you can just pick K random indices.
    //    /// Or continue with your K-Means++ logic using the local arrays:
    //
    //    for i in 1..<k {
    //      distanceSquared(
    //        x0: storage.greenStorage.baseAddress, x1: centroids[i - 1].green,
    //        y0: storage.blueStorage.baseAddress, y1: centroids[i - 1].blue,
    //        z0: storage.redStorage.baseAddress, z1: centroids[i - 1].red,
    //        n: storage.greenStorage.count,
    //        result: tmp.baseAddress)
    //
    //      guard let weightedRandomIndex = weightedRandomIndex(tmp) else {
    //        print("Couldn't create the next centroid.")
    //        break
    //      }
    //
    //      centroids.append(
    //        Centroid(
    //          red: storage.redStorage[weightedRandomIndex],
    //          green: storage.greenStorage[weightedRandomIndex],
    //          blue: storage.blueStorage[weightedRandomIndex]))
    //    }

    return centroids
  }

  private func updateCentroids(
    r: [Float],
    g: [Float],
    b: [Float],
    assignments: [Int],
    k: Int
  ) -> [Centroid] {
    // 1. Create buckets to store the sums and counts for each centroid
    var redSums = [Float](repeating: 0, count: k)
    var greenSums = [Float](repeating: 0, count: k)
    var blueSums = [Float](repeating: 0, count: k)
    var counts = [Float](repeating: 0, count: k)

    // 2. Single pass: Accumulate values
    // While this is a loop, Swift's compiler optimizes this heavily.
    for i in 0..<r.count {
      let label = assignments[i]
      redSums[label] += r[i]
      greenSums[label] += g[i]
      blueSums[label] += b[i]
      counts[label] += 1
    }

    // 3. Use vDSP to calculate the new means (Sum / Count)
    // This replaces the old centroids with new ones
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
        // If a centroid has no pixels, keep it as is or re-randomize
        newCentroids.append(Centroid(red: 0, green: 0, blue: 0))
      }
    }

    return newCentroids
  }

  private func centroidsAreConverged(
    old: [Centroid], new: [Centroid], tolerance: Float = 0.001
  ) -> Bool {
    guard old.count == new.count else { return false }

    var totalMovement: Float = 0

    for i in 0..<old.count {
      let dr = old[i].red - new[i].red
      let dg = old[i].green - new[i].green
      let db = old[i].blue - new[i].blue

      // Euclidean distance squared
      totalMovement += (dr * dr + dg * dg + db * db)
    }

    // If the average movement per centroid is less than our tolerance, we are done
    return (totalMovement / Float(old.count)) < (tolerance * tolerance)
  }

  static func createRGBFloatFormat() -> vImage_CGImageFormat {
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
    return format

  }

}

// Logic-only structure (no UI dependencies)
//struct ColorClusteringProcessor {
//
//  public func didSetCentroids() {
//    allocateDistancesBuffer()
//    calculateKMeans()
//  }
//
//  public func setUp(_ fileURL: URL) {
//    print("Ran setup method once the image is downloaded. It should exist at \(fileURL)")
//    self.imageFileURL = fileURL
//    generateThumbnailRepresentations()
//    calculateKMeans()
//  }
//
//
//  func calculate(url: URL, k: Int) async throws -> (colors: [DominantColor], image: CGImage?) {
//
//
//    // 1. Load and scale image using vImage
//    // 2. Initialize Centroids (K-Means++)
//    // 3. Run Loop (Replace BNNS calls here)
//
//    // Strategy for 'argMin' without deprecated ReductionLayer:
//    // Use BNNSGraph if k is large, or a simple loop with vDSP_minvi
//    // if k is small (like 2-8).
//
//    return ([], nil)
//  }
//}
//
//extension ColorClusteringProcessor {
//
//  /// Updates centroids and returns true if pixel counts haven't changed (that is, the solution converged).
//  ///
//  /// 1. Create k random centroids selected from the RGB colors in an image.
//  /// 2. Create a distances matrix that has pixel-count columns and k rows.
//  /// 3. For each centroid, populate the corresponding row in distances matrix with the distance-squared
//  /// between it and each matrix.
//  /// 4. Use BNNS reduction argMin on the distances matrix to create a vector with pixel-count elements.
//  /// Each element in the vector is the centroid that's the closest color to the corresponding pixel.
//  /// 5. For each centroid, use BNNS gather to create a new vector for each RGB channel of the pixel
//  /// colors for that centroid. Compute the mean value of that vector and set the centroid color to that average.
//  /// 6. Repeat steps 3, 4, and 5 until the solution converges.
//  /// - Tag: updateCentroids
//
//
//  func updateCentroids() -> Bool {
//    print("Updating centroids.")
//    // The pixel counts per centroid before this iteration.
//    let pixelCounts = centroids.map { return $0.pixelCount }
//
//    populateDistances()
//    let centroidIndices = makeCentroidIndices()
//
//    for centroid in centroids.enumerated() {
//
//      // The indices into the red, green, and blue descriptors for this centroid.
//      let indices = centroidIndices.enumerated().filter {
//        $0.element == centroid.offset
//      }.map {
//        // `vDSP.gather` uses one-based indices.
//        UInt($0.offset + 1)
//      }
//
//      centroids[centroid.offset].pixelCount = indices.count
//
//      if !indices.isEmpty {
//        let gatheredRed = vDSP.gather(
//          storage.redStorage,
//          indices: indices)
//
//        let gatheredGreen = vDSP.gather(
//          storage.greenStorage,
//          indices: indices)
//
//        let gatheredBlue = vDSP.gather(
//          storage.blueStorage,
//          indices: indices)
//
//        centroids[centroid.offset].red = vDSP.mean(gatheredRed)
//        centroids[centroid.offset].green = vDSP.mean(gatheredGreen)
//        centroids[centroid.offset].blue = vDSP.mean(gatheredBlue)
//      }
//    }
//
//    return pixelCounts.elementsEqual(centroids.map { return $0.pixelCount }) { a, b in
//      return abs(a - b) < tolerance
//    }
//  }
//
//
//
//  public func calculateKMeans() {
//    print("Running `calculateKMeans`...")
//    guard let url = self.imageFileURL else {
//      print("No image file path yet")
//      return
//    }
//
//    guard let cgImage = ThumbnailGenerator.cgImageFromURL(url) else {
//      print("Unable to create a CGImage from URL")
//      return
//    }
//
//    self.sourceImage = cgImage
//    self.quantizedImage = sourceImage
//
//    guard let unwrappedRGBFormat = rgbImageFormat else {
//      print("Failed to get value for `rgbImageFormat`")
//      return
//    }
//
//    var mutableRGBFormat = unwrappedRGBFormat
//
//    guard let sourceImage,
//          let rgbSources = try? vImage.PixelBuffer<vImage.InterleavedFx3>(
//            cgImage: sourceImage,
//            cgImageFormat: &mutableRGBFormat
//          ).planarBuffers()
//    else {
//      fatalError("Couldn't get rgb sources?")
//    }
//
//    rgbSources[0].scale(destination: storage.redBuffer)
//    rgbSources[1].scale(destination: storage.greenBuffer)
//    rgbSources[2].scale(destination: storage.blueBuffer)
//
//    self.isBusy = true
//
//    initializeCentroids()
//    updateCentroidNodes()
//    update()
//  }
//
//}
