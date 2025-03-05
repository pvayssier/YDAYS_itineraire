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
                .target(name: "Map"),
                .target(name: "Auth"),
                .target(name: "Profile"),
            ],
            path: "Sources/Core"),
        .target(
            name: "Map",
            dependencies:[
                .target(name: "SearchBar"),
                .target(name: "Profile"),
            ],
            path: "Sources/Map"),
        .target(
            name: "SearchBar",
            dependencies:[],
            path: "Sources/SearchBar"),
        .target(
            name: "Auth",
            dependencies: [
                .target(name: "Tools"),
                .target(name: "Map"),
                .target(name: "Models"),
                .target(name: "UI")
            ],
            path: "Sources/Auth"),
        .target(
            name: "Tools",
            dependencies: [
                .target(name: "Models")
            ],
            path: "Sources/Tools"),
        .target(
            name: "Models",
            dependencies: [],
            path: "Sources/Models"),
        .target(
            name: "UI",
            dependencies: [],
            path: "Sources/UI"),
        .target(
            name: "Profile",
            dependencies: [
                .target(name: "Models"),
                .target(name: "UI"),
                .target(name: "Tools")
            ],
            path: "Sources/Profile"),
    ]
)
