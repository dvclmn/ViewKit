//
//  PopupMessageView.swift
//  Eucalypt
//
//  Created by Dave Coleman on 5/2/2024.
//

//import BaseUI
import BaseHelpers
import SwiftUI
import SharedHelpers

@MainActor
public struct PopupView: View {

  @Environment(\.popup) private var popup
  @Environment(\.isDebugMode) private var isDebugMode
  
  @State private var isHoveringDismiss: Bool = false
  @State private var shouldStartProgressBar: Bool = false

  private let maxWidth: Double = 240
  private let minWidth: Double = 180
  private let rounding: CGFloat = Styles.sizeRegular

  let popupMessage: PopupMessage?
  let isCompact: Bool
  let hasCloseButton: Bool

  public init(
    _ message: PopupMessage?,
    isCompact: Bool = false,
    hasCloseButton: Bool = false,
  ) {
    self.popupMessage = message
    self.isCompact = isCompact
    self.hasCloseButton = hasCloseButton
  }

  public var body: some View {

    if let popupMessage {
      VStack {
        VStack(spacing: isCompact ? 4 : 6) {

          PopupTitle(popupMessage.title, icon: popupMessage.icon)
          if let messageDetail = popupMessage.message {
            Text(messageDetail)
              .foregroundStyle(.secondary)
              .font(.callout.weight(.medium))
          }
          if let action = popupMessage.action {
            Button(action.title) {
              return action.action()
            }
          }

        }  // END vstack
        
        //      .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
        .multilineTextAlignment(.leading)
        .fixedSize(horizontal: false, vertical: true)
        
        .padding(.horizontal, isCompact ? 12 : 20)
        .padding(.top, isCompact ? 8 : 13)
        .padding(.bottom, isCompact ? 10 : isShowingIndicator ? Styles.sizeMedium.bump : 16)
        .overlay(alignment: .topTrailing) {
          if hasCloseButton {
            DismissButton()
          }
        }
        .overlay(alignment: .bottom) {
          if let duration = popupMessage.dismissal.autoDismissDuration, isShowingIndicator {
            Capsule()
              .fill(.quaternary)
              .frame(maxWidth: progressBarLength, maxHeight: 5)
              .padding(.horizontal, Styles.sizeSmall.bump)
              .padding(.bottom, Styles.sizeSmall.bumpDown)
              .animation(.linear(duration: duration), value: shouldStartProgressBar)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: rounding))
        .overlay {
          RoundedRectangle(cornerRadius: rounding)
            .fill(.clear)
            .stroke(LinearGradient.lightFalloff(), style: .simple01)
        }
        .shadow(color: .black.opacity(0.2), radius: 40, x: 0, y: 18)
        .shadow(color: .black.opacity(0.2), radius: 9, x: 0, y: 1)
      }
      .compositingGroup()
      .id(popupMessage.id)
      .onAppear {
        if popupMessage.dismissal.autoDismissDuration != nil {
          self.shouldStartProgressBar = true
        } else {
          self.shouldStartProgressBar = false
        }
      }
    }

  }
}

extension PopupView {
  
  var isShowingIndicator: Bool {
    popupMessage?.dismissal.shouldShowDismissTimingIndicator ?? false
  }
  
  var progressBarLength: CGFloat {
    shouldStartProgressBar ? .infinity : .zero
  }
  @ViewBuilder
  func PopupContent(_ message: PopupMessage) -> some View {

  }

  @ViewBuilder
  func PopupTitle(_ title: String, icon: String?) -> some View {

    Group {
      if let icon {

        Label {
          Text(title)
        } icon: {
          Image(systemName: icon)
            .foregroundStyle(.secondary)
        }

      } else {
        Text(title)
      }
    }
    .font(.system(size: isCompact ? 11 : 14))
    .fontWeight(.medium)

    /// To leave room for the dismiss button
    .padding(.trailing, hasCloseButton ? 20 : 0)

  }

  @ViewBuilder
  func DismissButton() -> some View {
    Button {
      popup?.popupMessage = nil
    } label: {
      Label("Dismiss", systemImage: Icons.cross.icon)
        .labelStyle(.iconOnly)
        .font(.caption.weight(.bold))
        .foregroundStyle(isHoveringDismiss ? .secondary : .tertiary)
        .padding(Styles.sizeSmall)
        .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .onHover { hovering in
      isHoveringDismiss = hovering
    }
  }
}
