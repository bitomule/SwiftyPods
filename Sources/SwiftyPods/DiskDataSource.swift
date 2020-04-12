import Foundation

protocol FileStoring {
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws
}

final class DiskDataSource: FileStoring {
    private let manager: FileManager
    private let encoding: String.Encoding
    
    init(manager: FileManager = FileManager.default, encoding: String.Encoding = .utf8) {
        self.manager = manager
        self.encoding = encoding
    }
    
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws {
        let newFile = path.appendingPathComponent(name).path
        if(overwrite || !manager.fileExists(atPath:newFile)){
            manager.createFile(atPath: newFile, contents: content.data(using: encoding), attributes: nil)
        }else{
            print("File is already created")
        }
    }
}
