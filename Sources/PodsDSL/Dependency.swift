import Foundation

public struct Dependency {
    public let name: String
    public let version: String
    
    public init(name: String, version: String) {
        self.name = name
        self.version = version
    }
}

extension Dependency {
    public func toString() -> String {
        "pod '\(name)', '\(version)'"
    }
}
