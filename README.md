# SheetKit

A simple to use bottom sheet view that mimicks the behavior of the Apple Maps bottom sheet.

![demo](./Readme%20Images/SheetKit%20Demo.gif)

## ARCHIVED

As of iOS 16.0 this functionality is built into iOS. This repository is now archived.

## Usage
Usage of SheetKit is quite simple. Simply apply the `.bottomSheet(sheetState:content:)` view modifier to your view.

### Example

```
import SheetKit

struct MyView: View {
	@State var sheetState: SheetState = .halfPage

	var body: some View {
		Color.red
			.ignoresSafeArea()
			.bottomSheet(sheetState: $sheetState) {
				Text("This is the contents of the Sheet")
			}
	}
}
```

### Navigation Support
SheetKit supports SwiftUI's build in navigation paradigm out of the box. Any child views with `NavigationLink` in their body will navigate as expected.

```
import SheetKit

struct MyView: View {
	@State var sheetState: SheetState = .halfPage

	var body: some View {
		Color.red
			.ignoresSafeArea()
			.bottomSheet(sheetState: $sheetState) {
				NavigationLink(
					destination: List(Array(0...100), id: \.self){ num in
							Text("\(num)")
						}
						.navigationBarTitle(Text("Destination List"))
						.navigationBarTitleDisplayMode(.inline),
						.navigationBarItems(trailing: Button {
							withAnimation {
								state = .closed
							}
						} label: {
							Text("Close")
						})
					label: {
						Text("Show List")
					})
					.navigationBarTitle(Text("Main View"))
					.navigationBarTitleDisplayMode(.inline)
				)
			}
	}
}
```

