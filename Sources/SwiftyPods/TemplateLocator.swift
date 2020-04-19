import Foundation

protocol TemplateLocating {
    func findTemplates(at path: URL) throws -> [URL]
}

final class TemplateLocator: TemplateLocating {
    enum Constant {
        static let templateName = "podfile.swift"
    }
    
    private let manager: FileManager
    
    init(manager: FileManager = FileManager.default) {
        self.manager = manager
    }
    
    func findTemplates(at path: URL) throws -> [URL] {
        try manager
            .enumerator(at: path, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles], errorHandler: nil)?
            .allObjects
            .map { $0 as! URL }
            .filter { url in
                let resourceValues = try url.resourceValues(forKeys: [.isDirectoryKey])
                return !(resourceValues.isDirectory ?? true)
            }
            .filter { $0.lastPathComponent == Constant.templateName } ?? []
    }
}
