//
//  SheetKitLibraryProvider.swift
//  
//
//  Created by Brent Mifsud on 2021-04-27.
//

import SwiftUI

public struct SheetKitLibraryProvider: LibraryContentProvider {
	@LibraryContentBuilder public var views: [LibraryItem] {
		LibraryItem(
			BottomSheet(sheetState: .constant(.halfPage)) {
				Text("Placeholder")
			},
			title: "Bottom Sheet",
			category: .control,
			matchingSignature: "sheet"
		)
	}
	
	@LibraryContentBuilder public func modifiers(base: AnyView) -> [LibraryItem] {
		LibraryItem(
			base.bottomSheet(state: .constant(.halfPage)) {
				Text("Placeholder")
			},
			title: "Bottom Sheet",
			category: .control,
			matchingSignature: "sheet"
		)
	}
}
