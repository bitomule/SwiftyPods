import Foundation
import Storage

public protocol TemplateRendering {
    func render(
        template: String,
        context: [String: String],
        targetName: String,
        targetPath: URL
    ) throws
    
    func render(
        templateFile: URL,
        context: [String: String],
        targetName: String,
        targetPath: URL
    ) throws
}

public final class TemplateRenderer: TemplateRendering {
    enum Constant {
        static let fileName = "podfile"
    }
    
    private let storage: FileSysteming
    
    public init(storage: FileSysteming = FileSystem()){
        self.storage = storage
    }
    
    public func render(
        template: String,
        context: [String: String],
        targetName: String,
        targetPath: URL
    ) throws {
        let content = context.reduce(template) { result, dict in
            print(dict.value)
            return generateFile(template: result, value: dict.value, keyToReplace: dict.key)
        }
        try storage.saveFile(name: targetName, path: targetPath, content: content, overwrite: true)
    }
    
    public func render(
        templateFile: URL,
        context: [String: String],
        targetName: String,
        targetPath: URL
    ) throws {
        let template = try storage.getFile(at: templateFile)
        print(template)
        let content = context.reduce(template) { result, dict in
            print(dict.value)
            return generateFile(template: result, value: dict.value, keyToReplace: dict.key)
        }
        try storage.saveFile(name: targetName, path: targetPath, content: content, overwrite: true)
    }
    
    private func generateFile(template: String, value: String, keyToReplace: String) -> String {
        template.replacingOccurrences(of: "{{\(keyToReplace)}}", with: value)
    }
    
    private func filePath(from url: URL) -> String {
        url.deletingLastPathComponent().relativeString
    }
    
    private func fileName(from url: URL) -> String {
        url.lastPathComponent
    }
}
