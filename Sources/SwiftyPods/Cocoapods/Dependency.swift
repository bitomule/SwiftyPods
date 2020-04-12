import Foundation

public struct Dependency: TargetAttribute {
    public let name: String
    public let podName: String
    public let version: String
    
    init(name: String, podName: String, version: String) {
        self.name = name
        self.podName = podName
        self.version = version
    }
}

public struct CustomAttribute: TargetAttribute {
    public let value: String
    
    init(_ value: String) {
        self.value = value
    }
}

@_functionBuilder
struct DependencyBuilder {
    static func buildBlock(_ segments: TargetAttribute...) -> [TargetAttribute] {
        segments
    }
}
