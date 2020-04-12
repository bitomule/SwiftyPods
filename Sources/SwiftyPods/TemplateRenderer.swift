import Foundation
import Stencil
import PathKit

final class TemplateRenderer {
    enum Constant {
        static let fileName = "podfile"
    }
    
    private let storage: FileStoring
    
    init(storage: FileStoring = DiskDataSource()){
        self.storage = storage
    }
    
    func render(
        templatePath: URL,
        templateFileName: String,
        context: [String: String],
        targetPath: URL
    ) throws {
        let fsLoader = FileSystemLoader(paths: [Path(templatePath.relativePath)])
        let environment = Environment(loader: fsLoader)
        
        let content = try environment.renderTemplate(name: templateFileName, context: context)
        try storage.saveFile(name: Constant.fileName, path: targetPath, content: content, overwrite: true)
    }
}
