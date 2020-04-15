import Foundation
import Stencil
import Storage
import PathKit

public protocol StencilTemplateRendering {
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

public final class StencilTemplateRenderer: StencilTemplateRendering {
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
        let environment = Environment()
        let content = try environment.renderTemplate(string: template, context: context)
        try storage.saveFile(name: targetName, path: targetPath, content: content, overwrite: true)
    }
    
    public func render(
        templateFile: URL,
        context: [String: String],
        targetName: String,
        targetPath: URL
    ) throws {
        let templatePath = Path(filePath(from: templateFile))
        let fsLoader = FileSystemLoader(paths: [templatePath])
        let environment = Environment(loader: fsLoader)
        let content = try environment.renderTemplate(name: fileName(from: templateFile), context: context)
        try storage.saveFile(name: targetName, path: targetPath, content: content, overwrite: true)
    }
    
    private func filePath(from url: URL) -> String {
        url.deletingLastPathComponent().relativeString
    }
    
    private func fileName(from url: URL) -> String {
        url.lastPathComponent
    }
}
