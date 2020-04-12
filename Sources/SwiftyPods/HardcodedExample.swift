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
    Target(name: "TargetName") {
        Dependency(name: "Superpod", podName: "podName", version: "1.2.3")
        Target(name: "ChildTarget") {
            CustomAttribute("a")
        }
    }
}

