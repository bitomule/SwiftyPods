import Foundation

public struct Podfile {
    public let targets: [Target]
    
    private init(targets: [Target]) {
        self.targets = targets
    }
}

extension Podfile {
    public init(@TargetBuilder _ content: () -> [Target]) {
        self.init(targets: content())
    }
    
    public init( @TargetBuilder _ content: () -> Target) {
        self.init(targets: [content()])
    }
}

@_functionBuilder
struct TargetBuilder {
    static func buildBlock(_ segments: Target...) -> [Target] {
        segments
    }
}

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
