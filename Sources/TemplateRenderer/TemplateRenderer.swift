import Foundation
import Storage

public protocol TemplateRendering {
    func render(
        template: String,
        context: [String: String]
    ) throws -> String
    
    func render(
        templateFile: URL,
        context: [String: String]
    ) throws -> String
}

public final class TemplateRenderer: TemplateRendering {
    private let storage: FileSysteming
    
    public init(storage: FileSysteming = FileSystem()){
        self.storage = storage
    }
    
    public func render(
        template: String,
        context: [String: String]
    ) throws -> String {
        context.reduce(template) { result, dict in
            return generateFile(template: result, value: dict.value, keyToReplace: dict.key)
        }
    }
    
    public func render(
        templateFile: URL,
        context: [String: String]
    ) throws -> String {
        let template = try storage.getFile(at: templateFile)
        return context.reduce(template) { result, dict in
            return generateFile(template: result, value: dict.value, keyToReplace: dict.key)
        }
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
