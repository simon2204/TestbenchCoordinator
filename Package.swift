// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestbenchCoordinator",
	platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/simon2204/MoodleAPI.git", .branch("main")),
		.package(url: "https://github.com/simon2204/Testbench.git", .branch("main")),
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
		.package(url: "https://github.com/simon2204/swiftpdf.git", from: "1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "TestbenchCoordinator",
            dependencies: [
                "MoodleAPI",
				.product(name: "SwiftPDF", package: "swiftpdf"),
                .product(name: "Testbench", package: "Testbench"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "TestbenchCoordinatorTests",
            dependencies: ["TestbenchCoordinator"]),
    ]
)
