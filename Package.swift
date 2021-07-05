// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestbenchCoordinator",
    platforms: [.macOS(.v10_12)],
    dependencies: [
        .package(url: "https://github.com/simon2204/TestbenchMoodleAPI", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "TestbenchCoordinator",
            dependencies: [
                "TestbenchMoodleAPI",
                "TestbenchAPIUploader"
            ]
        ),
        .target(name: "TestbenchAPIUploader"),
        .testTarget(
            name: "TestbenchCoordinatorTests",
            dependencies: ["TestbenchCoordinator"]),
    ]
)
