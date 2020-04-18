import Foundation
import SwiftyPodsDSL

let podfile = Podfile {
    Target(
        name: "MainApp2",
        dependencies: [
            Dependency(name: "ExamplePod3", version: "1.2.3"),
            Dependency(name: "ExamplePod4", version: "3.2.1")
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
