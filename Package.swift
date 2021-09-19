// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SheetKit",
    platforms: [.iOS("15.0")],
	products: [
		.library(
			name: "SheetKit",
			targets: ["SheetKit"]),
	],
	targets: [
		.target(
			name: "SheetKit",
			dependencies: []),
	]
)
