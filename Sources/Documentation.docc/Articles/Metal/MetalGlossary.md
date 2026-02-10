
`float4 bounds` use case:
- Component access: .x, .y, .z, .w (or .r, .g, .b, .a for colors)
- Swizzling: You can create any combination like bounds.xy, bounds.wzyx, bounds.xxyy
- E.g. getting size from float4: `float2 size = bounds.zw;` or `float2 size = bounds.xy;` depending on what represents width/height in your bounds

```metal
float4 bounds;

// Individual components
float x = bounds.x;  // or bounds.r
float y = bounds.y;  // or bounds.g
float z = bounds.z;  // or bounds.b
float w = bounds.w;  // or bounds.a

// Your size derivation
float2 size = bounds.zw;     // width, height often stored in zw
float2 position = bounds.xy; // x, y often stored in xy

// Other useful swizzles
float2 flipped = bounds.wz;
float3 rgb = bounds.rgb;
float alpha = bounds.a;
float4 reversed = bounds.wzyx;
```


