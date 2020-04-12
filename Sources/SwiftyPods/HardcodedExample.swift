import Foundation

//let target = Target(
//    name: "MainApp",
//    dependencies: [
//        .pod(name: "SuperPod", podName: "podName", version: "2.3.4")
//    ],
//    childTargets: [
//        Target(name: "TestsMainApp", dependencies: [
//            .custom("inherit! :search_paths")
//            ]
//        )
//    ]
//)

let podfile = Podfile {
    Target(
        name: "MainApp",
        dependencies: [
            Dependency(name: "ExamplePod", podName: "ExamplePod", version: "1.2.3"),
            Dependency(name: "ExamplePod2", podName: "ExamplePod2", version: "3.2.1")
        ],
        childTargets: [
            Target(name: "Tests", dependencies: [
                Dependency(name: "TestPod", podName: "TestPod", version: "4.2.1")
                ]
            )
        ]
    )
}
