//
//  Home.swift
//  Custom Swipe Action
//
//  Created by Sagar Jangra on 29/08/2024.
//

import SwiftUI

struct Home: View {
    // Sample array
    @State private var colors: [Color] = [.black, .yellow, .purple, .brown]
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    SwipeAction(cornerRadius: 15, direction: .trailing) {
                        CardView(color)
                    } actions: {
                        Action(tint: .blue, icon: "star.fill") {
                            print("Bookmarked")
                        }
                        
                        Action(tint: .red, icon: "trash") {
                            withAnimation(.easeInOut) {
                                colors.removeAll(where: {$0 == color})
                            }
                        }
                    }
                    
                }
            }
            .padding(15)
        }
        .scrollIndicators(.hidden)
    }
    
    // Sample Card View
    func CardView(_ color: Color) -> some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 6, content: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 80, height: 5)
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 60, height: 5)
            })
            
            Spacer(minLength: 0)
        }
        .foregroundStyle(.white.opacity(0.4))
        .padding(.horizontal,15)
        .padding(.vertical, 10)
        .background(color.gradient)
    }
    
    // Custom Swipe Action View
    struct SwipeAction<Content:View>: View {
        var cornerRadius: CGFloat = 0
        var direction: SwipeDirection = .trailing
        
        @ViewBuilder var content: Content
        @ActionBuilder var actions: [Action]
        
        //View Properties
        @Environment(\.colorScheme) private var scheme
        // View Unique ID
        let viewID = UUID()
        @State private var isEnabled: Bool = true
        @State private var scrollOffSet: CGFloat = .zero
        
        var body: some View {
            // Used to reset the scroll view to its original position when a swipe action is pressed!
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        content
                        // To Take full Available Space
                            .containerRelativeFrame(.horizontal)
                            .background(scheme == .dark ? .black : .white)
                            .background {
                                if let firstAction = actions.first {
                                    Rectangle()
                                        .fill(firstAction.tint)
                                        .opacity(scrollOffSet == .zero ? 0 : 1)
                                }
                            }
                            .id(viewID)
                            .transition(.identity)
                            .overlay {
                                GeometryReader {
                                    let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                                    Color.clear
                                        .preference(key: OffSetKey.self, value: minX)
                                        .onPreferenceChange(OffSetKey.self) {
                                            scrollOffSet = $0
                                        }
                                }
                            }
                        
                        ActionButton {
                            withAnimation(.snappy) {
                                scrollProxy.scrollTo(viewID, anchor: direction == .trailing ? .topLeading: .topTrailing)
                            }
                        }
                        .opacity(scrollOffSet == .zero ? 0 : 1)
                    }
                    .scrollTargetLayout() // ViewAligned scroll target behavior requires scrollTargetLayout) to be added inside the ScrollView.
                    .visualEffect { content, geometryProxy in
                        content
                            .offset(x: scrollOffSet(geometryProxy))
                    }
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .background {
                    if let lastAction = actions.last {
                        Rectangle()
                            .fill(lastAction.tint)
                            .opacity(scrollOffSet == .zero ? 0 : 1)
                    }
                }
                .clipShape(.rect(cornerRadius: cornerRadius))
            }
            .allowsHitTesting(isEnabled)
            .transition(CustomTransition())
        }
        
        //Action Buttons
        @ViewBuilder
        func ActionButton(resetPosition: @escaping () -> ()) -> some View {
            // Each action button will have 100 width
            Rectangle()
                .fill(.clear)
                .frame(width: CGFloat(actions.count) * 100)
                .overlay(alignment: direction.alignment) {
                    HStack(spacing: 0) {
                        ForEach(actions) { button in
                            Button(action: {
                                Task {
                                    isEnabled = false
                                    resetPosition()
                                    try? await Task.sleep(for: .seconds(0.25))
                                    button.action()
                                    try? await Task.sleep(for: .seconds(0.1))
                                    isEnabled = true
                                }
                            }, label: {
                                Image(systemName: button.icon)
                                    .font(button.iconFont)
                                    .foregroundStyle(button.iconTint)
                                    .frame(width: 100)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(.rect)
                            })
                            .buttonStyle(.plain)
                            .background(button.tint)
                        }
                    }
                }
        }
        
        func scrollOffSet(_ proxy: GeometryProxy) -> CGFloat {
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            
            return direction == .trailing ? (minX > 0 ? -minX : 0) : (minX < 0 ? -minX : 0)
        }
    }
    
    // OffSet Key
    struct OffSetKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    // Custom Transition
    struct CustomTransition: Transition {
        func body(content: Content, phase: TransitionPhase) -> some View {
            content
                .mask {
                    GeometryReader {
                        let size = $0.size
                        
                        Rectangle()
                            .offset(y: phase == .identity ? 0: -size.height)
                        
                    }
                    .containerRelativeFrame(.horizontal)
                }
        }
    }
    
    // Swipe Direction
    enum SwipeDirection {
        case leading
        case trailing
        
        var alignment: Alignment {
            switch self {
            case .leading:
                return .leading
            case .trailing:
                return .trailing
            }
        }
    }
    
    /// Action Model
    struct Action: Identifiable {
        // Unique identifier for each instance of the struct, automatically generated as a UUID.
        // The 'id' can only be modified within the struct, but it can be accessed from outside.
        private(set) var id: UUID = .init()
        
        var tint: Color
        var icon: String
        var iconFont: Font = .title
        var iconTint: Color = .white
        var isEnabled: Bool = true
        var action: () -> ()
    }
    
    /// Just like ViewBuilder in SwiftUl, we can use @result builders in swift to build a result by combining multiple expressions into a single one using the 'build block'. This was introduced in Swift 5.4.
    
    @resultBuilder
    struct ActionBuilder {
        static func buildBlock(_ components: Action...) -> [Action] {
            return components
        }
    }
}

#Preview {
    Home()
}
