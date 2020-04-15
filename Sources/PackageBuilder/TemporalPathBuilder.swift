import Foundation

public protocol TemporalPathBuilding {
    func build(at path: URL) throws -> URL
}

public final class TemporalPathBuilder: TemporalPathBuilding {
    private let manager: FileManager
    
    public init(manager: FileManager = FileManager.default) {
        self.manager = manager
    }
    
    public func build(at path: URL) throws -> URL {
        let uuid = UUID().uuidString
        let tmpPath = "tmp/" + uuid + "/"
        let newPath = path.appendingPathComponent(tmpPath, isDirectory: true)
        try manager.createDirectory(atPath: newPath.relativePath, withIntermediateDirectories: true, attributes: nil)
        return newPath
    }
}
