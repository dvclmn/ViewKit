//
//  InterpolationBenchmark.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import Foundation
import SwiftUI

/// Performance benchmarking tool for path interpolation methods
struct PathInterpolationBenchmark {

  /// Benchmark results for a single test
  struct BenchmarkResult {
    let method: WaveInterpolation
    let pointCount: Int
    let iterations: Int
    let totalTime: TimeInterval
    let averageTime: TimeInterval
    let opsPerSecond: Double

    var formattedAverageTime: String {
      if averageTime < 0.001 {
        return String(format: "%.2f μs", averageTime * 1_000_000)
      } else if averageTime < 1.0 {
        return String(format: "%.2f ms", averageTime * 1000)
      } else {
        return String(format: "%.2f s", averageTime)
      }
    }

    var formattedOpsPerSecond: String {
      guard opsPerSecond > 1000 else {
        return String(format: "%.0f ops/s", opsPerSecond)
      }
      return String(format: "%.1fK ops/s", opsPerSecond / 1000)
    }
  }

  /// Run benchmark for a specific method
  static func benchmark(
    method: WaveInterpolation,
    points: [CGPoint],
    iterations: Int = 1000
  ) -> BenchmarkResult {
    let startTime = CFAbsoluteTimeGetCurrent()

    for _ in 0..<iterations {
      _ = Path.makePath(using: points, interpolation: method)
    }

    let endTime = CFAbsoluteTimeGetCurrent()
    let totalTime = endTime - startTime
    let averageTime = totalTime / Double(iterations)
    let opsPerSecond = Double(iterations) / totalTime

    return BenchmarkResult(
      method: method,
      pointCount: points.count,
      iterations: iterations,
      totalTime: totalTime,
      averageTime: averageTime,
      opsPerSecond: opsPerSecond
    )
  }

  /// Run comprehensive benchmark suite
  static func runFullBenchmark() -> [BenchmarkResult] {
    var results: [BenchmarkResult] = []

    // Test different point counts
    let pointCounts = [10, 50, 100, 200, 500]

    for count in pointCounts {
      let points = generateTestPoints(count: count)

      // Benchmark each method
      for method in [WaveInterpolation.linear, .cubic, .catmullRom] {
        let iterations = count < 100 ? 1000 : 500
        let result = benchmark(method: method, points: points, iterations: iterations)
        results.append(result)
      }
    }

    return results
  }

  /// Generate test points in a wave pattern
  private static func generateTestPoints(count: Int) -> [CGPoint] {
    var points: [CGPoint] = []
    let width: CGFloat = 400
    let height: CGFloat = 200

    for i in 0..<count {
      let t = CGFloat(i) / CGFloat(count - 1)
      let x = t * width
      let y = height / 2 + sin(t * .pi * 4) * height / 4
      points.append(CGPoint(x: x, y: y))
    }

    return points
  }
}

// MARK: - Benchmark View

struct BenchmarkView: View {
  @State private var results: [PathInterpolationBenchmark.BenchmarkResult] = []
  @State private var isRunning = false
  @State private var selectedPointCount = 100

  let pointCountOptions = [10, 50, 100, 200, 500]

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        // Controls
        VStack(alignment: .leading, spacing: 12) {
          Text("Benchmark Configuration")
            .font(.headline)

          HStack {
            Text("Points:")
            Picker("Point Count", selection: $selectedPointCount) {
              ForEach(pointCountOptions, id: \.self) { count in
                Text("\(count)").tag(count)
              }
            }
            .pickerStyle(.segmented)
          }

          Button(action: runBenchmark) {
            HStack {
              if isRunning {
                ProgressView()
                  .scaleEffect(0.8)
              }
              Text(isRunning ? "Running..." : "Run Benchmark")
            }
            .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)
          .disabled(isRunning)

          Button("Run Full Suite") {
            runFullBenchmark()
          }
          .buttonStyle(.bordered)
          .frame(maxWidth: .infinity)
          .disabled(isRunning)
        }
        .padding()
        .background(Color.black.secondary)
        .cornerRadius(12)

        // Results
        if !results.isEmpty {
          ScrollView {
            VStack(alignment: .leading, spacing: 16) {
              Text("Results")
                .font(.headline)

              // Group by point count
              ForEach(groupedResults(), id: \.key) { group in
                GroupBox("\(group.key) Points") {
                  VStack(spacing: 12) {
                    ForEach(group.value, id: \.method.name) { result in
                      ResultRow(result: result)
                    }
                  }
                }
              }

              // Performance comparison chart
              if let chartData = createChartData() {
                GroupBox("Performance Comparison") {
                  PerformanceChart(data: chartData)
                    .frame(height: 200)
                }
              }
            }
          }
        }

        Spacer()
      }
      .padding()
      .navigationTitle("Performance Benchmark")
    }
  }

  private func runBenchmark() {
    isRunning = true
    results.removeAll()

    DispatchQueue.global(qos: .userInitiated).async {
      let points = generateTestPoints(count: selectedPointCount)

      var newResults: [PathInterpolationBenchmark.BenchmarkResult] = []

      for method in [WaveInterpolation.linear, .cubic, .catmullRom] {
        let result = PathInterpolationBenchmark.benchmark(
          method: method,
          points: points,
          iterations: 1000
        )
        newResults.append(result)
      }

      DispatchQueue.main.async {
        self.results = newResults
        self.isRunning = false
      }
    }
  }

  private func runFullBenchmark() {
    isRunning = true
    results.removeAll()

    DispatchQueue.global(qos: .userInitiated).async {
      let newResults = PathInterpolationBenchmark.runFullBenchmark()

      DispatchQueue.main.async {
        self.results = newResults
        self.isRunning = false
      }
    }
  }

  private func generateTestPoints(count: Int) -> [CGPoint] {
    var points: [CGPoint] = []
    for i in 0..<count {
      let t = CGFloat(i) / CGFloat(count - 1)
      let x = t * 400
      let y = 200 + sin(t * .pi * 4) * 100
      points.append(CGPoint(x: x, y: y))
    }
    return points
  }

  private func groupedResults() -> [(key: Int, value: [PathInterpolationBenchmark.BenchmarkResult])] {
    let grouped = Dictionary(grouping: results, by: { $0.pointCount })
    return grouped.sorted { $0.key < $1.key }
  }

  private func createChartData() -> [(String, Double)]? {
    guard !results.isEmpty else { return nil }

    // Get results for the most recent point count
    let pointCount = results.last?.pointCount ?? selectedPointCount
    let relevantResults = results.filter { $0.pointCount == pointCount }

    return relevantResults.map { ($0.method.name, $0.averageTime * 1000) }
  }
}

// MARK: - Result Row

struct ResultRow: View {
  let result: PathInterpolationBenchmark.BenchmarkResult

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text(result.method.name)
          .font(.subheadline)
          .fontWeight(.semibold)

        Text("\(result.iterations) iterations")
          .font(.caption)
          .foregroundColor(.secondary)
      }

      Spacer()

      VStack(alignment: .trailing, spacing: 4) {
        Text(result.formattedAverageTime)
          .font(.subheadline)
          .fontWeight(.medium)

        Text(result.formattedOpsPerSecond)
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
    .padding(.vertical, 4)
  }
}

// MARK: - Performance Chart

struct PerformanceChart: View {
  let data: [(String, Double)]

  var body: some View {
    GeometryReader { geometry in
      HStack(alignment: .bottom, spacing: 12) {
        ForEach(data, id: \.0) { item in
          VStack(spacing: 4) {
            Text(String(format: "%.1fms", item.1))
              .font(.caption2)
              .foregroundColor(.secondary)

            RoundedRectangle(cornerRadius: 4)
              .fill(colorForMethod(item.0))
              .frame(height: barHeight(for: item.1, in: geometry.size.height))

            Text(item.0)
              .font(.caption)
              .lineLimit(1)
          }
          .frame(maxWidth: .infinity)
        }
      }
      .padding(.horizontal)
    }
  }

  private func barHeight(for value: Double, in maxHeight: CGFloat) -> CGFloat {
    let maxValue = data.map { $0.1 }.max() ?? 1.0
    let normalizedHeight = CGFloat(value / maxValue)
    return normalizedHeight * (maxHeight - 40)  // Leave space for labels
  }

  private func colorForMethod(_ method: String) -> Color {
    switch method {
      case "Linear": return .red
      case "Cubic Bezier": return .green
      case "Catmull-Rom": return .blue
      default: return .gray
    }
  }
}

// MARK: - Real-time Performance Monitor

struct RealtimePerformanceView: View {
  @State private var points: [CGPoint] = []
  @State private var selectedMethod: WaveInterpolation = .catmullRom
  @State private var frameTime: TimeInterval = 0
  @State private var fps: Double = 0

  private let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack(spacing: 0) {
      // Canvas
      Canvas { context, size in
        let startTime = CFAbsoluteTimeGetCurrent()

        let path = Path.makePath(using: points, interpolation: selectedMethod)
        context.stroke(path, with: .color(.blue), lineWidth: 2)

        // Draw points
        for point in points {
          let rect = CGRect(x: point.x - 3, y: point.y - 3, width: 6, height: 6)
          context.fill(Path(ellipseIn: rect), with: .color(.red))
        }

        let endTime = CFAbsoluteTimeGetCurrent()
        DispatchQueue.main.async {
          self.frameTime = endTime - startTime
          self.fps = 1.0 / max(0.001, self.frameTime)
        }
      }
      .gesture(
        DragGesture(minimumDistance: 0)
          .onChanged { value in
            points.append(value.location)
            // Limit point count to simulate real-world usage
            if points.count > 500 {
              points.removeFirst()
            }
          }
      )
      .background(Color.black.secondary)

      // Performance metrics
      VStack(alignment: .leading, spacing: 12) {
        Text("Real-time Performance")
          .font(.headline)

        HStack {
          VStack(alignment: .leading, spacing: 4) {
            Text("Frame Time:")
              .font(.caption)
            Text(String(format: "%.2f ms", frameTime * 1000))
              .font(.system(.body, design: .monospaced))
              .fontWeight(.semibold)
              .foregroundColor(frameTime > 0.016 ? .red : .green)
          }

          Spacer()

          VStack(alignment: .leading, spacing: 4) {
            Text("FPS:")
              .font(.caption)
            Text(String(format: "%.0f", fps))
              .font(.system(.body, design: .monospaced))
              .fontWeight(.semibold)
              .foregroundColor(fps < 60 ? .orange : .green)
          }

          Spacer()

          VStack(alignment: .leading, spacing: 4) {
            Text("Points:")
              .font(.caption)
            Text("\(points.count)")
              .font(.system(.body, design: .monospaced))
              .fontWeight(.semibold)
          }
        }

        Picker("Method", selection: $selectedMethod) {
          Text("Linear").tag(WaveInterpolation.linear)
          Text("Cubic").tag(WaveInterpolation.cubic)
          Text("Catmull-Rom").tag(WaveInterpolation.catmullRom)
        }
        .pickerStyle(.segmented)

        HStack {
          Button("Clear") {
            points.removeAll()
          }
          .buttonStyle(.bordered)

          Button("Generate Wave") {
            generateWave()
          }
          .buttonStyle(.bordered)
        }

        Text("Draw on the canvas above to test real-time performance")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding()
      .background(Color.black.secondary)
    }
    .onReceive(timer) { _ in
      // Update FPS display
    }
  }

  private func generateWave() {
    points.removeAll()
    for i in 0..<200 {
      let x = CGFloat(i) * 2
      let y = 200 + sin(CGFloat(i) * 0.1) * 100
      points.append(CGPoint(x: x, y: y))
    }
  }
}

// MARK: - Preview

#Preview("Benchmark") {
  BenchmarkView()
}

#Preview("Real-time Performance") {
  RealtimePerformanceView()
}
