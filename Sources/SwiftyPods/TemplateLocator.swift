import Foundation
import Storage

protocol TemplateLocating {
    func findTemplates(at path: URL) throws -> [URL]
}

final class TemplateLocator: TemplateLocating {
    enum Constant {
        static let templateName = "podfile.swift"
    }
    
    private let storage: FileSysteming
    
    init(storage: FileSysteming = FileSystem()) {
        self.storage = storage
    }
    
    func findTemplates(at path: URL) throws -> [URL] {
        try storage.findFilesInFolder(at: path, matching: { $0.lastPathComponent == Constant.templateName })
    }
}
