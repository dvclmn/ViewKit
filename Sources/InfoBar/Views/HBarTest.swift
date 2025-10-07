//
//  HBarTest.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/6/2025.
//

#warning("Take a look at this later some time")
//import SwiftUI
//
//struct TopMenu: View {
//  
//  @State private var show: Bool = false
//  
//  var body: some View {
//    VStack {
//      TopMenuView {
//        
//        Button("Change", action: { show.toggle() })
//        
//        Text("Hello world!")
//          .topMenuItems(leading: Image(systemName: show ? "xmark.circle" : "pencil"))
//          .topMenuItems(trailing: Image(systemName: show ? "pencil" : "xmark.circle"))
//      }
//    }
//  }
//}
//
//struct TopMenu_Previews: PreviewProvider {
//  static var previews: some View {
//    TopMenu()
//  }
//}
//
///*
// 
// To emulate .navigationBarItems(leading: View, trailing: View), I need four things:
// 
// 1) EquatableViewContainer - Because preferenceKeys need to be equatable to be able to update when a change occurred
// 2) PreferenceKeys - That use the EquatableViewContainer for both leading and trailing views
// 3) ViewExtenstions - That allow us to set the preferenceKeys individually or one at a time
// 4) TopMenu view - That we can set somewhere higher in the view hierarchy.
// 
// */
//
//// First, create an EquatableViewContainer we can use as preferenceKey data
//struct EquatableViewContainer: Equatable {
//  
//  let id = UUID().uuidString
//  let view: AnyView
//  
//  static func == (lhs: EquatableViewContainer, rhs: EquatableViewContainer) -> Bool {
//    return lhs.id == rhs.id
//  }
//}
//
//// Second, define preferenceKeys that uses the Equatable view container
//struct TopMenuItemsLeading: PreferenceKey {
//  static var defaultValue: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()) )
//  
//  static func reduce(value: inout EquatableViewContainer, nextValue: () -> EquatableViewContainer) {
//    value = nextValue()
//  }
//}
//
//struct TopMenuItemsTrailing: PreferenceKey {
//  static var defaultValue: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()) )
//  
//  static func reduce(value: inout EquatableViewContainer, nextValue: () -> EquatableViewContainer) {
//    value = nextValue()
//  }
//}
//
//// Third, create view-extensions for each of the ways to modify the TopMenu
//extension View {
//  
//  // Change only leading view
//  func topMenuItems<LView: View>(leading: LView) -> some View {
//    self
//      .preference(key: TopMenuItemsLeading.self, value: EquatableViewContainer(view: AnyView(leading)))
//  }
//  
//  // Change only trailing view
//  func topMenuItems<RView: View>(trailing: RView) -> some View {
//    self
//      .preference(key: TopMenuItemsTrailing.self, value: EquatableViewContainer(view: AnyView(trailing)))
//  }
//  
//  // Change both leading and trailing views
//  func topMenuItems<LView: View, TView: View>(leading: LView, trailing: TView) -> some View {
//    self
//      .preference(key: TopMenuItemsLeading.self, value: EquatableViewContainer(view: AnyView(leading)))
//  }
//}
//
//
//// Fourth, create the view for the TopMenu
//struct TopMenuView<Content: View>: View {
//  
//  // Content to put into the menu
//  let content: Content
//  
//  @State private var leading:EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()))
//  @State private var trailing:EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()))
//  
//  
//  init(@ViewBuilder content: @escaping () -> Content) {
//    self.content = content()
//  }
//  
//  var body: some View {
//    
//    VStack(spacing: 0) {
//      
//      ZStack {
//        
//        HStack {
//          
//          leading.view
//          
//          Spacer()
//          
//          trailing.view
//          
//        }
//        
//        Text("TopMenu").fontWeight(.black)
//      }
//      .padding(EdgeInsets(top: 0, leading: 2, bottom: 5, trailing: 2))
//      .background(Color.gray.edgesIgnoringSafeArea(.top))
//      
//      content
//      
//      Spacer()
//      
//    }
//    .onPreferenceChange(TopMenuItemsLeading.self, perform: { value in
//      leading = value
//    })
//    .onPreferenceChange(TopMenuItemsTrailing.self, perform: { value in
//      trailing = value
//    })
//    
//  }
//}
//`````
