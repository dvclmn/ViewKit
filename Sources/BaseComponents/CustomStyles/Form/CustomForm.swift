////
////  CustomForm.swift
////  Components
////
////  Created by Dave Coleman on 3/10/2024.
////
//
//import SwiftUI
//

//import BaseHelpers
//
//public struct SectionedFormConfig {
//  var spacing: CGFloat
//  let hasMaskEffect: Bool
//  var labelWidth: CGFloat?
//  var layout: Axis?
//  
//  public init(
//    spacing: CGFloat = Styles.sizeRegular,
//    hasMaskEffect: Bool = true,
//    labelWidth: CGFloat? = nil,
//    layout: Axis? = nil
//  ) {
//    self.spacing = spacing
//    self.hasMaskEffect = hasMaskEffect
//    self.labelWidth = labelWidth
//    self.layout = layout
//  }
//}
//
//public extension SectionedFormConfig {
//  static func layout(_ layout: Axis) -> Self {
//    Self(layout: layout)
//  }
//}
//
//// MARK: - Vertical layout
//public struct SectionedForm<Content: View>: View {
//  
//  let config: SectionedFormConfig
//  let content: Content
//  
//  public init(
//    _ config: SectionedFormConfig = .init(),
//    @ViewBuilder content: @escaping () -> Content
//  ) {
//    self.config = config
//    self.content = content()
//  }
//  
//  public var body: some View {
//    
//    OffsetScroll(config: .init(mode: config.hasMaskEffect ? .mask : .off)) {
//      content
//        .modifier(SectionGroupModifier())
////        .labeledContentStyle(.custom(labelWidth: config.labelWidth, layout: config.layout))
//        .padding(.horizontal, Styles.paddingToMatchForm)
//        .toggleStyle(.switch)
//    }
//  }
//}
//
//
//
//
////public extension SectionedForm {
////  var noMaskEffect: Self {
////    let result = SectionedForm(
////      spacing: spacing,
////      hasMaskEffect: false,
////      content: content as! () -> Content
////    )
////    return result
////  }
////}
//
//
////public enum OSVersion {
////  case macOS15
////  case macOS14
////}
//
////public struct CustomForm<Content: View>: View {
////
////  var osVersion: OSVersion
////  var content: Content
////
////  public init(
////    osVersion: OSVersion = .macOS15,
////    @ViewBuilder content: () -> Content
////  ) {
////    self.osVersion = osVersion
////    self.content = content()
////  }
////
////  public var body: some View {
////
////    if #available(macOS 15.0, *) {
////
////      switch osVersion {
////        case .macOS14:
////          OS14()
////
////        case .macOS15:
////
////          VStack(spacing: Styles.sizeMedium) {
////
////            Group(sections: content) { sections in
////
////              /// This is looping over any `Section`s found in the content
////              ForEach(sections) { section in
////
////                /// This will determine the spacing between *Sections*
////                VStack {
////                  //                VStack(spacing: Styles.sizeMedium) {
////
////                  if !section.header.isEmpty {
////                    FormSectionHeader {
////                      section.header
////                    }
////                  }
////
////                  FormSection {
////
////                    /// This loop over all *resolved* views. This can be anything; `Text`, `LabeledContent`, `Button` etc.
////                    ForEach(section.content) { subview in
////
////                      FormSectionContent(isLast: subview.id == section.content.last?.id) {
////                        subview
////                      }
////                      //                        .border(Color.pink.opacity(0.3))
////
////                    } // END foreach subview
////                  } // END section contents
////                } // END per-section vstack
////
////              } // END sections foreach
////
////            } // END sections Group
////
////          } // END main vstack
////          .labeledContentStyle(.custom)
////
////      } // END switch
////
////    } else {
////
////      OS14()
////
////    }
////  }
////}
////
////
////
////public struct FormSection<Content: View>: View {
////  @ViewBuilder var content: Content
////
////  public var body: some View {
////    VStack(spacing: Styles.sizeSmall) {
////      content
////        .frame(maxWidth: .infinity)
////
////    }
////    .buttonStyle(.custom.lightBackground.titleOnly)
////    //    .border(Color.green.opacity(0.3))
////    .padding(.top, Styles.sizeSmall.bump)
////    .padding(.horizontal, Styles.sizeRegular)
////    .padding(.bottom, Styles.sizeMedium)
////
////    .background {
////      RoundedRectangle(cornerRadius: Styles.sizeSmall)
////        .fill(.quinary.opacity(0.3))
////        .stroke(.quaternary, style: .init(lineWidth: 1))
////    }
////
////  }
////}
////
////
////public struct FormSectionContent<Content: View>: View {
////
////  var isLast: Bool
////  @ViewBuilder var content: Content
////
////  public var body: some View {
////
////    VStack {
////      content
////      if !isLast {
////        Divider()
////          .opacity(0.5)
////      }
////    }
////
////
////  }
////}
////
////public struct FormSectionHeader<Content: View>: View {
////  @ViewBuilder var content: Content
////
////  public var body: some View {
////
////    content
////      .frame(maxWidth: .infinity, alignment: .leading)
////
////  }
////}
////
////
////extension CustomForm {
////
////  @ViewBuilder
////  func OS14() -> some View {
////    Form {
////      content
////    }
////    .formStyle(.grouped)
////    .scrollContentBackground(.hidden)
////    .textFieldStyle(.plain)
////    .buttonStyle(.custom.lightBackground.titleOnly)
////    //    .labelStyle(.custom)
////    .labeledContentStyle(.custom)
////  }
////}
////
////
