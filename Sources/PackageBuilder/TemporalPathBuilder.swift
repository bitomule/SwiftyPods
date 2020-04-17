import Foundation
import Storage

public protocol TemporalPathBuilding {
    func build(at path: URL) throws -> URL
    func getRootTemporalPath() -> String
}

public final class TemporalPathBuilder: TemporalPathBuilding {
    enum Constant {
        static let temporalFolderPath = "tmp/"
    }
    private let storage: FileSysteming
    
    public init(storage: FileSysteming = FileSystem()) {
        self.storage = storage
    }
    
    public func build(at path: URL) throws -> URL {
        let uuid = UUID().uuidString
        let tmpPath = Constant.temporalFolderPath + uuid + "/"
        let newPath = path.appendingPathComponent(tmpPath, isDirectory: true)
        try storage.createFolder(at: newPath)
        return newPath
    }
    
    public func getRootTemporalPath() -> String {
        Constant.temporalFolderPath
    }
}
