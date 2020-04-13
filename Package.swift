// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyPods",
    products: [
        .executable(name: "swiftypods", targets: ["SwiftyPods"]),
        .library(name: "PodsDSL", targets: ["PodsDSL"]),
        .library(name: "TemplateLocator", targets: ["TemplateLocator"]),
        .library(name: "PackageBuilder", targets: ["PackageBuilder"]),
        .library(name: "StencilTemplateRenderer", targets: ["StencilTemplateRenderer"]),
        .library(name: "Storage", targets: ["Storage"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.13.0")
    ],
    targets: [
        .target(
            name: "SwiftyPods",
            dependencies: [
                "ArgumentParser",
                "Stencil",
                "PodsDSL",
                "PackageBuilder",
                "StencilTemplateRenderer",
                "Storage"
        ]),
        .target(
            name: "PodsDSL",
            dependencies: []
        ),
        .target(
            name: "TemplateLocator",
            dependencies: []
        ),
        .target(
            name: "PackageBuilder",
            dependencies: [
                "Stencil",
                "TemplateLocator",
                "StencilTemplateRenderer",
                "Storage"
        ]),
        .target(
            name: "StencilTemplateRenderer",
            dependencies: [
                "Stencil"
        ]),
        .target(
            name: "Storage",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftyPodsTests",
            dependencies: ["SwiftyPods"]),
    ]
)
