import Foundation

public struct Dependency {
    public let name: String
    public let version: String
    
    init(name: String, version: String) {
        self.name = name
        self.version = version
    }
}

extension Dependency {
    func toString() -> String {
        "pod '\(name)', '\(version)'"
    }
}
