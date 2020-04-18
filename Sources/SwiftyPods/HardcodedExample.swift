import Foundation
import SwiftyPodsDSL

let podfile = Podfile {
    Target(
        name: "MainApp",
        dependencies: [
            Dependency(name: "ExamplePod", version: "1.2.3"),
            Dependency(name: "ExamplePod2", version: "3.2.1")
        ],
        childTargets: [
            Target(name: "Tests", dependencies:
                [
                    Dependency(name: "TestPod", version: "4.2.1")
                ]
            )
        ]
    )
}
