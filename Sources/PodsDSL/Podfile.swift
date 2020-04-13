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
    public static func buildBlock(_ segments: Target...) -> [Target] {
        segments
    }
}
