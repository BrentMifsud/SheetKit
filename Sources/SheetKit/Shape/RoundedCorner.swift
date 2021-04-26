//
//  RoundedCorner.swift
//  
//
//  Created by Brent Mifsud on 2021-04-26.
//

import SwiftUI

struct RoundedCorner: Shape {
	var cornerRadius: CGFloat
	var corners: UIRectCorner
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(
			roundedRect: rect,
			byRoundingCorners: corners,
			cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
		)

		return Path(path.cgPath)
	}
}

struct RoundedCorner_Previews: PreviewProvider {
	static var previews: some View {
		Color.red
			.ignoresSafeArea()
			.overlay(
				Color.white
					.frame(width: 100, height: 100, alignment: .center)
					.clipShape(RoundedCorner(cornerRadius: 16, corners: [.bottomLeft, .topRight]))
			)
	}
}
