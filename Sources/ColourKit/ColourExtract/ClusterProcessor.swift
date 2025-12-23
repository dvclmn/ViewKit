//
//  ClusterProcessor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/12/2025.
//

import SwiftUI

// Logic-only structure (no UI dependencies)
struct ColorClusteringProcessor {
  
  public func didSetCentroids() {
    allocateDistancesBuffer()
    calculateKMeans()
  }
  
  public func setUp(_ fileURL: URL) {
    print("Ran setup method once the image is downloaded. It should exist at \(fileURL)")
    self.imageFileURL = fileURL
    generateThumbnailRepresentations()
    calculateKMeans()
  }

  
  func calculate(url: URL, k: Int) async throws -> (colors: [DominantColor], image: CGImage?) {
    
    
    // 1. Load and scale image using vImage
    // 2. Initialize Centroids (K-Means++)
    // 3. Run Loop (Replace BNNS calls here)
    
    // Strategy for 'argMin' without deprecated ReductionLayer:
    // Use BNNSGraph if k is large, or a simple loop with vDSP_minvi
    // if k is small (like 2-8).
    
    return ([], nil)
  }
}

extension ColorClusteringProcessor {
  
  /// Updates centroids and returns true if pixel counts haven't changed (that is, the solution converged).
  ///
  /// 1. Create k random centroids selected from the RGB colors in an image.
  /// 2. Create a distances matrix that has pixel-count columns and k rows.
  /// 3. For each centroid, populate the corresponding row in distances matrix with the distance-squared
  /// between it and each matrix.
  /// 4. Use BNNS reduction argMin on the distances matrix to create a vector with pixel-count elements.
  /// Each element in the vector is the centroid that's the closest color to the corresponding pixel.
  /// 5. For each centroid, use BNNS gather to create a new vector for each RGB channel of the pixel
  /// colors for that centroid. Compute the mean value of that vector and set the centroid color to that average.
  /// 6. Repeat steps 3, 4, and 5 until the solution converges.
  /// - Tag: updateCentroids
  

  func updateCentroids() -> Bool {
    print("Updating centroids.")
    // The pixel counts per centroid before this iteration.
    let pixelCounts = centroids.map { return $0.pixelCount }
    
    populateDistances()
    let centroidIndices = makeCentroidIndices()
    
    for centroid in centroids.enumerated() {
      
      // The indices into the red, green, and blue descriptors for this centroid.
      let indices = centroidIndices.enumerated().filter {
        $0.element == centroid.offset
      }.map {
        // `vDSP.gather` uses one-based indices.
        UInt($0.offset + 1)
      }
      
      centroids[centroid.offset].pixelCount = indices.count
      
      if !indices.isEmpty {
        let gatheredRed = vDSP.gather(
          storage.redStorage,
          indices: indices)
        
        let gatheredGreen = vDSP.gather(
          storage.greenStorage,
          indices: indices)
        
        let gatheredBlue = vDSP.gather(
          storage.blueStorage,
          indices: indices)
        
        centroids[centroid.offset].red = vDSP.mean(gatheredRed)
        centroids[centroid.offset].green = vDSP.mean(gatheredGreen)
        centroids[centroid.offset].blue = vDSP.mean(gatheredBlue)
      }
    }
    
    return pixelCounts.elementsEqual(centroids.map { return $0.pixelCount }) { a, b in
      return abs(a - b) < tolerance
    }
  }
  
  
  
  public func calculateKMeans() {
    print("Running `calculateKMeans`...")
    guard let url = self.imageFileURL else {
      print("No image file path yet")
      return
    }
    
    guard let cgImage = ThumbnailGenerator.cgImageFromURL(url) else {
      print("Unable to create a CGImage from URL")
      return
    }
    
    self.sourceImage = cgImage
    self.quantizedImage = sourceImage
    
    guard let unwrappedRGBFormat = rgbImageFormat else {
      print("Failed to get value for `rgbImageFormat`")
      return
    }
    
    var mutableRGBFormat = unwrappedRGBFormat
    
    guard let sourceImage,
          let rgbSources = try? vImage.PixelBuffer<vImage.InterleavedFx3>(
            cgImage: sourceImage,
            cgImageFormat: &mutableRGBFormat
          ).planarBuffers()
    else {
      fatalError("Couldn't get rgb sources?")
    }
    
    rgbSources[0].scale(destination: storage.redBuffer)
    rgbSources[1].scale(destination: storage.greenBuffer)
    rgbSources[2].scale(destination: storage.blueBuffer)
    
    self.isBusy = true
    
    initializeCentroids()
    updateCentroidNodes()
    update()
  }

}
