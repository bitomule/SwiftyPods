// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyPodsTemporalProject",
    products: [
        .executable(name: "SwiftyPodsTemporalProject", targets: ["SwiftyPodsTemporalProject"]),],
    dependencies: [
        .package(url: "git@github.com:bitomule/SwiftyPods", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/bitomule/SwiftyPodsDSL", .branch("master"))
    ],
    targets: [
        .target(
            name: "SwiftyPodsTemporalProject",
            dependencies: [
                "ArgumentParser",
                "SwiftyPodsDSL",
                "PodfileBuilder"
            ],
            path: ""
        )
    ]
)
