//
//  AsyncImageView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 24/9/2025.
//

// import BaseHelpers
import NukeUI
import SwiftUI
import SharedHelpers

public struct AsyncImageView<AdditionalContent: View>: View {
  @Environment(\.iconFontSize) private var iconFontSize
  @Environment(\.explicitAspectRatio) private var explicitAspectRatio
  @Environment(\.explicitContentMode) private var explicitContentMode
  @Environment(\.cornerRounding) private var cornerRounding

  private let errorColour: Color = .orange
  private let placeholderColour: Color = .gray

  let url: String?
  let content: (Image?) -> AdditionalContent

  public init(
    url: String?,
    @ViewBuilder content: @escaping (Image?) -> AdditionalContent
  ) {
    self.url = url
    self.content = content
  }

  public var body: some View {

    if let url = url?.toURL {
      Lazy(url: url)

    } else {
      PlaceholderView(isLoading: false, error: nil)
    }
  }
}

extension AsyncImageView {

  //  @ViewBuilder
  //  private func Async(url: URL?) -> some View {
  //    AsyncImage(url: url) { phase in
  //      ZStack {
  //        if let image = phase.image {
  //          content(image.resizable())
  //            /// Note: `nil` is the right value here, so the image is
  //            /// not distorted undesirably
  //            .aspectRatio(nil, contentMode: explicitContentMode ?? .fill)
  //        } else {
  //          PlaceholderView(isLoading: false, error: phase.error)
  //        }
  //      }  // END zstack
  //      /// A general animation that smooths over any loading and popping in of image
  //      //      .animation(Styles.animationSmoother, value: phase.image)
  //    }  // END AsyncImage
  //  }

  @ViewBuilder
  private func Lazy(url: URL?) -> some View {
    LazyImage(url: url) { state in

      ZStack {
        if let image = state.image {
          content(image.resizable())
            /// Note: `nil` is the right value here, so the image is
            /// not distorted undesirably
            .aspectRatio(nil, contentMode: explicitContentMode ?? .fill)
        } else {
          content(nil)
          PlaceholderView(isLoading: state.isLoading, error: state.error)
        }
      }
      //      .animation(Styles.animationSmoother, value: state.image)
    }
  }

  @ViewBuilder
  private func PlaceholderView(
    isLoading: Bool,
    error: Error?
      //    _ phase: AsyncImagePhase
  ) -> some View {
    ZStack {

      if let error {
        RoundedRectangle(cornerRadius: cornerRounding ?? Styles.sizeSmall)
          .fill(Color.purple.opacityLow)

        //        if error != nil {
        Image(systemName: "photo.badge.exclamationmark")
          .font(.system(size: iconFontSize ?? 30))
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(.secondary)
          .onTapGesture {
            print("Tapped image, here is the error: \(error)")
          }
        //            .helpButton(text: AttributedString(error.localizedDescription))
      }

      if isLoading {
        ProgressView()
          .controlSize(.small)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .opacity(0.6)
      }

    }

    //      .fill(error != nil ? Color.purple.opacityLow : Color.gray.opacityLow)
    //      .fill(phase.colour.opacity(0.2))
    //    .overlay {
    //      if isLoading, error != nil {
    //        ProgressView()
    //          .controlSize(.small)
    //          .frame(maxWidth: .infinity, maxHeight: .infinity)
    //          .opacity(0.6)
    //      }
    //
    //    }
  }
}
