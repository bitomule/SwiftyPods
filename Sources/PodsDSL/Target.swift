import Foundation

public struct Target {
    public let name: String
    public let dependencies: [Dependency]
    public let childTargets: [Target]
    
    public init(
        name: String,
        dependencies: [Dependency],
        childTargets: [Target] = []
    ) {
        self.name = name
        self.dependencies = dependencies
        self.childTargets = childTargets
    }
}
