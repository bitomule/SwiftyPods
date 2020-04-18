import SwiftyPodsDSL

let podfile = Podfile(targets: [
    .target(name: "Target1", project: "Path to project", dependencies: [
        .dependency(name: "podname")
    ])
])

//let podfile = Podfile {
//    Target(
//        name: "MainApp",
//        dependencies: [
//            Dependency(name: "ExamplePod", version: "1.2.3"),
//            Dependency(name: "ExamplePod2", version: "3.2.1")
//        ],
//        childTargets: [
//            Target(name: "Tests", dependencies:
//                [
//                    Dependency(name: "TestPod", version: "4.2.1")
//                ]
//            )
//        ]
//    )
//}
