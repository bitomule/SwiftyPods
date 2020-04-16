import Foundation

public protocol FileSymlinking {
    func linkFile(at: URL, to: URL) throws
}

public final class FileSimlinker: FileSymlinking {
    private let manager: FileManager
    
    public init (manager: FileManager = FileManager.default) {
        self.manager = manager
    }
    
    public func linkFile(at: URL, to: URL) throws {
        try manager.createSymbolicLink(at: at, withDestinationURL: to)
    }
}
