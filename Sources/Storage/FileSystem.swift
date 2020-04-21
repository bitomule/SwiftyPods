import Foundation

public enum FileSystemError: Error {
    case fileDoesNotExists(String)
}

public protocol FileSysteming {
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws
    func getFile(at: URL) throws -> String
    func copyFile(from: URL, to: URL, override: Bool) throws
    func delete(at path: String) throws
    func createFolder(at url:URL) throws
    func findFilesInFolder(at url: URL, matching: (URL) -> Bool) throws -> [URL]
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
    
    public func copyFile(from: URL, to: URL, override: Bool) throws {
        guard manager.fileExists(atPath: from.path) else {
            throw FileSystemError.fileDoesNotExists(from.path)
        }
        if override && manager.fileExists(atPath: to.path) {
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
    
    public func createFolder(at url: URL) throws {
        try manager.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
    }
    
    public func findFilesInFolder(at url: URL, matching: (URL) -> Bool) throws -> [URL] {
        try manager
            .enumerator(at: url, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles], errorHandler: nil)?
            .allObjects
            .map { $0 as! URL }
            .filter { url in
                let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey])
                return !(resourceValues.isDirectory ?? true)
        }
        .filter(matching) ?? []
    }
}
