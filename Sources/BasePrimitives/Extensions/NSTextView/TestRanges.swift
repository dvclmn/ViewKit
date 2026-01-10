//
//  TestRanges.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/12/2025.
//

import SwiftUI

//struct TextRangeDemoView: View {
//  @State private var nsRange = NSRange(location: 0, length: 20)
//  @State private var results: [String] = []
//  
//  var body: some View {
//    VStack(alignment: .leading, spacing: 20) {
//      Text("NSRange to NSTextRange Conversion Demo")
//        .font(.title2)
//        .padding(.bottom)
//      
//      Text("Demonstrating the potential bug in end location calculation")
//        .font(.headline)
//        .foregroundColor(.red)
//      
//      Divider()
//      
//      VStack(alignment: .leading, spacing: 10) {
//        Text("Test NSRange:")
//        Text("Location: \(nsRange.location), Length: \(nsRange.length)")
//          .font(.system(.body, design: .monospaced))
//          .padding(.horizontal)
//          .background(Color.gray.opacity(0.2))
//      }
//      
//      Button("Test Current Method (Potential Bug)") {
//        testCurrentMethod()
//      }
//      .buttonStyle(.borderedProminent)
//      
//      Button("Test Fixed Method (More Robust)") {
//        testFixedMethod()
//      }
//      .buttonStyle(.bordered)
//      
//      ScrollView {
//        VStack(alignment: .leading, spacing: 8) {
//          ForEach(results.indices, id: \.self) { index in
//            Text(results[index])
//              .font(.system(.body, design: .monospaced))
//              .padding(8)
//              .background(index == 0 ? Color.red.opacity(0.1) :
//                            index == 1 ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
//          }
//        }
//      }
//      .frame(height: 200)
//      
//      Text("Explanation:")
//        .font(.headline)
//      
//      Text("""
//            The potential bug occurs because we calculate the end location from the start:
//            ```
//            end = location(start, offsetBy: range.length)
//            ```
//            
//            This assumes text layout is linear, but with complex text (emoji, ligatures, 
//            right-to-left text), offsets might not be additive.
//            
//            The fix calculates both from the document start:
//            ```
//            start = location(docStart, offsetBy: range.location)
//            end = location(docStart, offsetBy: range.location + range.length)
//            ```
//            """)
//      .font(.caption)
//      .padding()
//      .background(Color.blue.opacity(0.1))
//      
//      Spacer()
//    }
//    .padding()
//    .frame(width: 600, height: 700)
//  }
//  
//  // Simulates the current (potentially buggy) method
//  func testCurrentMethod() {
//    results.removeAll()
//    
//    // Create a test string with complex characters
//    let testString = "Hello 🇺🇸World👨‍👩‍👧‍👦123"
//    results.append("Test string: \(testString)")
//    results.append("String length: \(testString.count)")
//    results.append("UTF-16 length: \((testString as NSString).length)")
//    
//    // Simulate the bug
//    let docStart = 0
//    let rangeLocation = 6  // After "Hello "
//    let rangeLength = 7     // Should capture "🇺🇸World"
//    
//    // Current method (potential bug)
//    let start = docStart + rangeLocation  // Simulated: location(docStart, offsetBy: range.location)
//    let end = start + rangeLength         // Simulated: location(start, offsetBy: range.length)
//    
//    results.append("\nCURRENT METHOD (potential bug):")
//    results.append("Start index: \(start)")
//    results.append("End index: \(end)")
//    results.append("Expected substring: '🇺🇸World'")
//    
//    let nsString = testString as NSString
//    if end <= nsString.length {
//      let substring = nsString.substring(with: NSRange(location: start, length: rangeLength))
//      results.append("Actual substring: '\(substring)'")
//      
//      let expected = "🇺🇸World"
//      if substring == expected {
//        results.append("✓ Matched expected!")
//      } else {
//        results.append("✗ MISMATCH! This is the bug in action.")
//        results.append("  The flag emoji 🇺🇸 is 4 UTF-16 code units,")
//        results.append("  so additive offsets can misalign.")
//      }
//    }
//  }
//  
//  // Simulates the fixed method
//  func testFixedMethod() {
//    results.removeAll()
//    
//    let testString = "Hello 🇺🇸World👨‍👩‍👧‍👦123"
//    results.append("Test string: \(testString)")
//    results.append("String length: \(testString.count)")
//    results.append("UTF-16 length: \((testString as NSString).length)")
//    
//    // Test with the same range
//    let docStart = 0
//    let rangeLocation = 6
//    let rangeLength = 7
//    
//    // Fixed method (more robust)
//    let start = docStart + rangeLocation  // Simulated: location(docStart, offsetBy: range.location)
//    let end = docStart + rangeLocation + rangeLength  // Simulated: location(docStart, offsetBy: range.location + range.length)
//    
//    results.append("\nFIXED METHOD (more robust):")
//    results.append("Start index: \(start)")
//    results.append("End index: \(end)")
//    results.append("Expected substring: '🇺🇸World'")
//    
//    let nsString = testString as NSString
//    if end <= nsString.length {
//      let substring = nsString.substring(with: NSRange(location: start, length: end - start))
//      results.append("Actual substring: '\(substring)'")
//      
//      let expected = "🇺🇸World"
//      if substring == expected {
//        results.append("✓ Matched expected!")
//      } else {
//        results.append("✗ Still mismatched")
//      }
//    }
//    
//    results.append("\nNote: In real NSTextContentManager,")
//    results.append("the difference is in how 'location' handles")
//    results.append("complex text boundaries vs simple offsets.")
//  }
//}
//
//// For a more realistic demonstration with actual NSTextView
//struct RealTextDemoView: View {
//  var body: some View {
//    VStack {
//      Text("Real NSTextView Demonstration")
//        .font(.title2)
//      
//      Text("""
//            The bug would manifest with:
//            1. Emoji sequences (flags, family emoji)
//            2. Right-to-left text mixed with left-to-right
//            3. Ligatures (like "fi" in some fonts)
//            4. Surrogate pairs
//            
//            In these cases, character count ≠ UTF-16 count,
//            so additive offsets from start can drift.
//            """)
//      .padding()
//      .background(Color.yellow.opacity(0.1))
//      
//      Divider()
//      
//      Text("Example of problematic text:")
//        .font(.headline)
//      
//      VStack(alignment: .leading) {
//        Text("🇺🇸 Flag emoji: 1 character, 4 UTF-16 units")
//        Text("👨‍👩‍👧‍👦 Family: 1 character, 11 UTF-16 units")
//        Text("اَلْعَرَبِيَّةُ Arabic with diacritics")
//        Text("café with accent: 4 characters, 4 UTF-16 units")
//      }
//      .font(.system(.body, design: .monospaced))
//      .padding()
//      
//      Spacer()
//    }
//    .padding()
//    .frame(width: 600, height: 400)
//  }
//}
//
//#if DEBUG
//
//#Preview {
//
//  TabView {
//    TextRangeDemoView()
//      .tabItem {
//        Label("Range Bug Demo", systemImage: "ant.circle")
//      }
//    
//    RealTextDemoView()
//      .tabItem {
//        Label("Real Examples", systemImage: "text.alignleft")
//      }
//  }
//  .frame(width: 600, height: 700)
//}
//#endif
