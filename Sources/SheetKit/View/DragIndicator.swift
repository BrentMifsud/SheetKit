//
//  DragIndicator.swift
//  
//
//  Created by Brent Mifsud on 2021-04-26.
//

import SwiftUI

struct DragIndicator: View {
	var body: some View {
		Capsule()
			.fill(Color(.systemFill))
			.frame(width: 36, height: 6)
			.fixedSize()
	}
}

struct DragIndicator_Previews: PreviewProvider {
	static var previews: some View {
		Color(.systemBackground)
			.overlay(DragIndicator(), alignment: .top)
	}
}
