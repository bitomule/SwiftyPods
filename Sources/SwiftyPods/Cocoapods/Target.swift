import Foundation

public struct Podfile {
    public let targets: [Target]
    
    init(targets: [Target]) {
        self.targets = targets
    }
}

extension Podfile {
    public init(@TargetBuilder _ content: () -> [Target]) {
        self.init(targets: content())
    }
    
    public init(@TargetBuilder _ content: () -> Target) {
        self.init(targets: [content()])
    }
}

public protocol TargetAttribute {}

public struct Target: TargetAttribute {
    public let name: String
    public let attributes: [TargetAttribute]
    
    public init(
        name: String,
        attributes: [TargetAttribute]
    ) {
        self.name = name
        self.attributes = attributes
    }
}

extension Target {
    public init(name: String, @DependencyBuilder _ content: () -> [TargetAttribute]) {
        self.init(name: name, attributes: content())
    }
    
    public init(name: String, @DependencyBuilder _ content: () -> TargetAttribute) {
        self.init(name: name, attributes: [content()])
    }
}

@_functionBuilder
struct TargetBuilder {
    static func buildBlock(_ segments: Target...) -> [Target] {
        segments
    }
}
