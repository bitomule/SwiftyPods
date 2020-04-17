import Foundation

public enum FileSystemError: Error {
    case fileDoesNotExists(String)
}

public protocol FileSysteming {
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws
    func getFile(at: URL) throws -> String
    func copyFile(from: URL, to: URL) throws
    func delete(at path: String) throws
}

public final class FileSystem: FileSysteming {
    private let manager: FileManager
    private let encoding: String.Encoding
    
    public init(manager: FileManager = FileManager.default, encoding: String.Encoding = .utf8) {
        self.manager = manager
        self.encoding = encoding
    }
    
    public func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws {
        let newFile = path.appendingPathComponent(name).path
        if(overwrite || !manager.fileExists(atPath:newFile)){
            manager.createFile(atPath: newFile, contents: content.data(using: encoding), attributes: nil)
        } else{
            print("File is already created")
        }
    }
    
    public func copyFile(from: URL, to: URL) throws {
        guard manager.fileExists(atPath: from.path) else {
            throw FileSystemError.fileDoesNotExists(from.path)
        }
        if manager.fileExists(atPath: to.path) {
            try manager.removeItem(at: to)
        }
        try manager.copyItem(at: from, to: to)
    }
    
    public func getFile(at url: URL) throws -> String {
        try String(contentsOf: url)
    }
    
    public func delete(at path: String) throws {
        try manager.removeItem(atPath: path)
    }
}
