//
//  checkerboard.metal
//  BaseHelpers
//
//  Created by Dave Coleman on 17/2/2026.
//

// Full credit to Paul Hudson (twostraws)
// https://www.github.com/twostraws/Inferno

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;



/// A shader that renders a two-colour checkerboard pattern.
///
/// The checkerboard is anchored to the centre of the image, so the pattern
/// scales outward from the middle when `size` changes. An `offset` parameter
/// lets you slide the pattern in X and Y independently.
///
/// The XOR trick works by dividing each pixel's position by `size` to find
/// which square it lives in, then XOR-ing the integer column and row indices.
/// Because XOR produces a 1 in any bit where the two inputs differ, checking
/// the lowest bit tells us whether exactly one of (column, row) is odd —
/// which is precisely the alternating condition we need for a checkerboard.
///
/// - Parameter position: The user-space coordinate of the current pixel.
/// - Parameter color: The current color of the pixel (unused, but required by the signature).
/// - Parameter primary: The colour used for "even" squares.
/// - Parameter secondary: The colour used for "odd" squares.
/// - Parameter size: The side length of each square, in user-space.
/// - Parameter imageSize: The full size of the image, used to derive the centre origin.
/// - Parameter offset: An X/Y translation applied to the pattern before tiling.

[[ stitchable ]] half4 checkerboard(
                                    float2 position,
                                    float4 bounds,
                                    half4 primary,
                                    half4 secondary,
                                    float size,
                                    float2 offset
                                    ) {
  // Shift the coordinate system so (0,0) is the centre of the image,
  // then apply the caller-supplied offset.
  float2 viewSize = bounds.zw;
  float2 centred = position - (viewSize * 0.5) - offset;
  
  // Determine which square we're in, rounding toward negative infinity
  // so the grid is symmetric around the centre.
  // floor() is used instead of a bare uint cast because casting a negative
  // float to uint is undefined behaviour; floor gives us the correct
  // mathematical "tile index" for negative coordinates too.
  int2 posInChecks = int2(floor(centred.x / size), floor(centred.y / size));
  
  // XOR the column and row, then test the lowest bit.
  bool isSecondary = (posInChecks.x ^ posInChecks.y) & 1;
  
  return isSecondary ? secondary : primary;
}



// Simpler version, with no centring
/// A shader that renders a two-colour checkerboard pattern, tiled from the
/// top-leading origin.
///
/// - Parameter position: The user-space coordinate of the current pixel.
/// - Parameter color: The current color of the pixel (unused, but required by the signature).
/// - Parameter primary: The colour used for "even" squares.
/// - Parameter secondary: The colour used for "odd" squares.
/// - Parameter size: The side length of each square, in user-space.
/// - Parameter offset: An X/Y translation applied to the pattern before tiling.
//[[ stitchable ]] half4 checkerboard(
//                                    float2 position,
//                                    half4 primary,
//                                    half4 secondary,
//                                    float size,
//                                    float2 offset
//                                    ) {
//  uint2 posInChecks = uint2((position - offset) / size);
//  bool isSecondary = (posInChecks.x ^ posInChecks.y) & 1;
//  return isSecondary ? secondary : primary;
//}
