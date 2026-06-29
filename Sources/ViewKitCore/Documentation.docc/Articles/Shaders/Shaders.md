
This is what's typically added at the top of a `.metal` file:
```
#include <metal_stdlib>
using namespace metal;
```

And for Layer Effect shaders, an additional header file import is needed:
```metal
#include <SwiftUI/SwiftUI_Metal.h>
```

[Read more](https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:))

