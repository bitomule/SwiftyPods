import Foundation

public struct Dependency {
    public let name: String
    public let podName: String
    public let version: String
    
    init(name: String, podName: String, version: String) {
        self.name = name
        self.podName = podName
        self.version = version
    }
}

public struct CustomAttribute {
    public let value: String
    
    init(_ value: String) {
        self.value = value
    }
}
