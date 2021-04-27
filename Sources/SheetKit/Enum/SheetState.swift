//
//  SheetState.swift
//  
//
//  Created by Brent Mifsud on 2021-04-26.
//

import SwiftUI

/// The different states a `BottomSheet` can be in.
public enum SheetState: Identifiable, Hashable {
	case closed
	case minimized
	case halfPage
	case maximized
	
	public var id: SheetState {
		return self
	}
	
	/// These values are meant to replicate the Apple Maps bottom sheet states.
	internal var maxHeight: CGFloat {
		switch self {
		case .closed:
			return 0
		case .minimized:
			return UIScreen.main.bounds.height * (1 / 8)
		case .halfPage:
			return UIScreen.main.bounds.height * (3 / 8)
		case .maximized:
			return UIScreen.main.bounds.height * (7 / 8)
		}
	}
}
