import Foundation
import SwiftyPodsDSL

let example = Podfile(
    targets: [
        .target(
            name: "Target",
            project: "Project",
            dependencies: [
                .dependency(name: "Dependency1"),
                .dependency(name: "Dependency2",
                            version: "1.2.3"),
                .dependency(name: "Dependency3",
                            .git(url: "repo"),
                            .branch(name: "master"))
            ],
            childTargets: [
                .target(name: "ChildTarget", project: "Project2")
            ]
        )
    ]
)
