// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Frameworks",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Frameworks",
            targets: ["Core"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Core",
            dependencies: [
                .target(name: "Map")
            ],
            path: "Sources/0-Core"),
        .target(
            name: "Coordinator",
            dependencies: [
                .target(name: "Map")
            ],
            path: "Sources/1-Coordinator"),
        .target(
            name: "Map",
            dependencies:[
                .target(name: "Tools")
            ],
            path: "Sources/2-Map"),
        .target(
            name: "Tools",
            dependencies:[],
            path: "Sources/3-Tools")
    ]
)
