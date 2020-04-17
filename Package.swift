// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyPods",
    products: [
        .executable(name: "swiftypods", targets: ["SwiftyPods"]),
        .library(name: "PodsDSL", targets: ["PodsDSL"]),
        .library(name: "PodfileBuilder", targets: ["PodfileBuilder"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/kareman/SwiftShell", from: "5.0.1")
    ],
    targets: [
        .target(
            name: "SwiftyPods",
            dependencies: [
                "ArgumentParser",
                "PodsDSL",
                "PackageBuilder",
                "TemplateRenderer",
                "Storage",
                "SwiftShell"
        ]),
        .target(
            name: "PodsDSL",
            dependencies: []
        ),
        .target(
            name: "PackageBuilder",
            dependencies: [
                "TemplateRenderer",
                "Storage",
                "SwiftShell"
        ]),
        .target(
            name: "TemplateRenderer",
            dependencies: [
                "Storage"
        ]),
        .target(
            name: "Storage",
            dependencies: []
        ),
        .target(
            name: "PodfileBuilder",
            dependencies: [
                "Storage",
                "SwiftShell",
                "TemplateRenderer",
                "PodsDSL"
            ]
        ),
        .testTarget(
            name: "SwiftyPodsTests",
            dependencies: ["SwiftyPods"]),
    ]
)
