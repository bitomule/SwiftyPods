// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyPods",
    products: [
        .executable(name: "swiftypods", targets: ["SwiftyPods"]),
        .library(name: "PodfileBuilder", targets: ["PodfileBuilder"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/kareman/SwiftShell", from: "5.0.1"),
        .package(url: "https://github.com/bitomule/SwiftyPodsDSL", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "SwiftyPods",
            dependencies: [
                "ArgumentParser",
                "SwiftyPodsDSL",
                "PackageBuilder",
                "TemplateRenderer",
                "Storage",
                "SwiftShell"
        ]),
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
                "SwiftyPodsDSL"
            ]
        ),
        .testTarget(
            name: "TemplateRendererTests",
            dependencies: [
                "TemplateRenderer",
                "Storage"
        ]),
        .testTarget(
            name: "SwiftyPodsTests",
            dependencies: [
                "SwiftyPods"
        ]),
    ]
)
