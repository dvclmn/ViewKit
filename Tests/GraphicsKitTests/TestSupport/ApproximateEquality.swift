import Testing

/// Checks floating-point results while preserving the test call site in
/// failure diagnostics.
///
/// Decimal values and π generally cannot be represented exactly by a binary
/// floating-point type. The tolerance describes the maximum acceptable
/// numerical error; it is not a tolerance for logically incorrect behaviour.
func expectApproximatelyEqual(
  _ actual: Double,
  _ expected: Double,
  tolerance: Double = 1e-9,
  sourceLocation: SourceLocation = #_sourceLocation
) {
  #expect(
    abs(actual - expected) <= tolerance,
    sourceLocation: sourceLocation
  )
}
