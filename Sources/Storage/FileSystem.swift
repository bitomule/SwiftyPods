import Foundation

public protocol FileSysteming {
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws
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
        }else{
            print("File is already created")
        }
    }
}
