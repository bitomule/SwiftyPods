import Foundation
import Storage

protocol TemporalPathBuilding {
    func build(at path: URL) throws -> URL
    func getRootTemporalPath() -> String
}

final class TemporalPathBuilder: TemporalPathBuilding {
    enum Constant {
        static let temporalFolderPath = "tmp/"
    }
    private let storage: FileSysteming
    
    init(storage: FileSysteming = FileSystem()) {
        self.storage = storage
    }
    
    func build(at path: URL) throws -> URL {
        let uuid = UUID().uuidString
        let tmpPath = Constant.temporalFolderPath + uuid + "/"
        let newPath = path.appendingPathComponent(tmpPath, isDirectory: true)
        try storage.createFolder(at: newPath)
        return newPath
    }
    
    func getRootTemporalPath() -> String {
        Constant.temporalFolderPath
    }
}
