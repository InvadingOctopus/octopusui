// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

// https://github.com/InvadingOctopus/octopusui

import PackageDescription

let package = Package(
    name: "OctopusUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .visionOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OctopusUI",
            targets: ["OctopusUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OctopusUI"),
        .testTarget(
            name: "OctopusUITests",
            dependencies: ["OctopusUI"]),
    ],
    swiftLanguageModes: [.v6]
)

