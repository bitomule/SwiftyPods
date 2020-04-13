import Foundation
import Stencil
import PathKit
import Storage

public protocol StencilTemplateRendering {
    func render(
        templatePath: URL,
        templateFileName: String,
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
        templatePath: URL,
        templateFileName: String,
        context: [String: String],
        targetName: String,
        targetPath: URL
    ) throws {
        let fsLoader = FileSystemLoader(paths: [Path(templatePath.relativePath)])
        let environment = Environment(loader: fsLoader)
        
        let content = try environment.renderTemplate(name: templateFileName, context: context)
        try storage.saveFile(name: Constant.fileName, path: targetPath, content: content, overwrite: true)
    }
}
