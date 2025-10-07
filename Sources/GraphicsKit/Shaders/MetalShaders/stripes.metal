//
//  stripes.metal
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// Abstract:
// A shader that applies stripes of multiple colors
// to a shape when using it as a SwiftUI `ShapeStyle`.

[[ stitchable ]]
half4 stripes(
              float2 position,
              float thickness,
              device const half4 *ptr,
              int count
              ) {
  int i = int(floor(position.y / thickness));
  
  // Clamp to 0 ..< count.
  i = ((i % count) + count) % count;
  
  return ptr[i];
}
