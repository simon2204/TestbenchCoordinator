// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestbenchCoordinator",
	platforms: [.macOS(.v12)],
    dependencies: [
		.package(url: "https://pi-lab3.w-hs.de/Simon/MoodleAPI.git", from: "2.0.5"),
		.package(url: "https://pi-lab3.w-hs.de/PPRTestbench/Testbench.git", from: "1.0.0"),
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
		.package(url: "https://pi-lab3.w-hs.de/Simon/swiftpdf.git", branch: "main")
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
