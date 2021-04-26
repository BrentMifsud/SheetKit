//
//  SwiftUIView.swift
//  
//
//  Created by Brent Mifsud on 2021-04-26.
//

import SwiftUI

public struct BottomSheet<Content: View>: View {
	@Binding private var sheetState: SheetState
	private var content: Content
	
	@Environment(\.colorScheme) private var colorScheme
	@GestureState private var dragState: CGFloat = 0
	
	public init(sheetState: Binding<SheetState>, content: () -> Content) {
		self._sheetState = sheetState
		self.content = content()
	}
	
	public var body: some View {
		VStack(spacing: 0) {
			Color(colorScheme == .light ? .tertiarySystemFill : .secondarySystemFill).opacity(0.5)
				.frame(maxWidth: .infinity, maxHeight: 16)
				.overlay(DragIndicator())
			
			NavigationView {
				if sheetState == .halfPage || sheetState == .maximized {
					content
						.transition(.opacity)
				}
				
			}
			.navigationViewStyle(StackNavigationViewStyle())
		}
		.background(Color(.systemBackground))
		.frame(height: sheetState.maxHeight - dragState)
		.overlay(dragArea, alignment: .top)
		.clipShape(RoundedCorner(cornerRadius: 16, corners: [.topLeft, .topRight]))
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		.ignoresSafeArea()
		.simultaneousGesture(sheetState != .maximized ? dragGesture : nil)
		.animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.5), value: dragState)
	}
	
	private var dragGesture: some Gesture {
		DragGesture(minimumDistance: 0.1, coordinateSpace: .local)
			.updating($dragState) { value, state, transaction in
				state = value.translation.height
			}
			.onEnded { endValue in
				sheetState = nextSheetState(for: endValue.translation.height)
			}
	}
	
	private var dragArea: some View {
		Color(.white).opacity(0.00001) // Clear Backgrounds have no frame, so we have to use low opacity.
			.frame(width: 160, height: 60)
			.simultaneousGesture(dragGesture)
	}
	
	private func nextSheetState(for offset: CGFloat) -> SheetState {
		let smallChangeThreshold: CGFloat = UIScreen.main.bounds.height * ( 1 / 8 )
		let largeChangeThreshold: CGFloat = UIScreen.main.bounds.height * ( 1 / 2 )
		
		switch sheetState {
		case .minimized:
			if offset < -largeChangeThreshold {
				return .maximized
			} else if offset < -smallChangeThreshold {
				return .halfPage
			}
		case .halfPage:
			if offset > smallChangeThreshold {
				return .minimized
			} else if offset < -smallChangeThreshold {
				return .maximized
			}
		case .maximized:
			if offset > largeChangeThreshold {
				return .minimized
			} else if offset > smallChangeThreshold {
				return .halfPage
			}
		case .closed:
			return .closed
		}
		
		return sheetState
	}
}

public extension View {
	func bottomSheet<Content: View>(
		state: Binding<SheetState>,
		allowsNavigation: Bool = true,
		content: () -> Content
	) -> some View {
		ZStack {
			self.zIndex(0)
			
			BottomSheet<Content>(sheetState: state) {
				content()
			}
			.zIndex(1)
		}
	}
}

struct BottomSheet_Previews: PreviewProvider {
	struct TestView<Content: View>: View {
		@State var state: SheetState = .halfPage
		var content: Content
		
		init(content: @autoclosure () -> Content) {
			self.content = content()
		}

		var body: some View {
			Color.red
				.overlay(
					Button {
						state = .halfPage
					} label: {
						Text("Show Sheet")
					}
				)
				.ignoresSafeArea()
				.bottomSheet(state: $state, allowsNavigation: true) {
					content
						.navigationBarItems(trailing: Button {
							withAnimation {
								state = .closed
							}
						} label: {
							Text("Close")
						})
				}
		}
	}
	
	static var previews: some View {
		Group {
			TestView(
				content: Text("Text")
					.navigationBarTitle("Test")
					.navigationBarTitleDisplayMode(.inline)
			)
			.colorScheme(.dark)
			
			TestView(
				content: NavigationLink(
					destination: List(Array(0...100), id: \.self){ num in
							Text("\(num)")
						}
						.navigationBarTitle(Text("Destination"))
						.navigationBarTitleDisplayMode(.inline),
					label: {
						Text("Navigate")
					})
					.navigationBarTitle(Text("Main View"))
					.navigationBarTitleDisplayMode(.inline)
				)
		}
	}
}
