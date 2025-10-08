//
//  PreviewableImage.swift
//  Components
//
//  Created by Dave Coleman on 11/1/2025.
//

import BaseHelpers
import SwiftUI

//public struct PreviewableImage: View {
//  @Environment(\.accentColour) private var accentColour
//
//  /// The aim is that this could either be an image asset, or a URL
//  /// This is fragile, because it'll only work if there's a corresponding
//  /// image in the assets folder
//  let imageReference: String?
//  
//  public init(
//    imageReference: String?
//  ) {
//    self.imageReference = imageReference
//  }
//  
//  private let isPreviewModeActive: Bool = false
//
//  public var body: some View {
//
//    if isPreview && isPreviewModeActive {
//
//      if let imageReference {
//        Image(imageReference)
//          .resizable()
//      } else {
//        Image(systemName: "photo")
//      }
//
//    } else {
//
//      AsyncImage(url: imageReference?.url) { phase in
//
//        if let image = phase.image {
//          image
//            .resizable()
//            .scaledToFill()
//
//        } else if phase.error != nil {
//          DefaultError()
//          
//        } else {
//          DefaultPlaceholder()
//          
//        }
//      }  // END async image
//    }  // END is preview mode
//  }
//}
//extension PreviewableImage {
//  
//  @ViewBuilder
//  func DefaultError() -> some View {
//    /// Error state
//    
//    Color.white.opacity(0.1)
//      .overlay {
//        Image(systemName: "photo")
//          .symbolVariant(.slash)
//          .fontWeight(.semibold)
//          .foregroundStyle(.tertiary)
//      }
//  }
//  
//  @ViewBuilder
//  func DefaultPlaceholder() -> some View {
//    accentColour.opacity(0.3)  // Acts as a placeholder.
//      .overlay {
//        Image(systemName: "sdcard")
//          .symbolVariant(.slash)
//          .fontWeight(.semibold)
//          .foregroundStyle(.tertiary)
//        //                .spinning()
//      }
//  }
//}
