// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyPodsTemporalProject",
    products: [
        .executable(name: "SwiftyPodsTemporalProject", targets: ["SwiftyPodsTemporalProject"]),],
    dependencies: [
        .package(url: "https://github.com/bitomule/SwiftyPods", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "SwiftyPodsTemporalProject",
            dependencies: [
                "PodsDSL"
        ])
    ]
)
