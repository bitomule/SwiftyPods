import Foundation
import TemplateRenderer
import Storage

final class GenerateService {
    private enum Constant {
        static let templateFileName = "podfile"
    }
    private let templateArgumentParser: TemplateArgumentParser
    private let templateRenderer: TemplateRendering
    private let contextBuilder: TemplateContextBuilder
    private let storage: FileSysteming
    
    init(
        templateArgumentParser: TemplateArgumentParser = TemplateArgumentParser(),
        templateRenderer: TemplateRendering = TemplateRenderer(),
        contextBuilder: TemplateContextBuilder = ContentBuilder(),
        storage: FileSysteming = FileSystem()
    ) {
        self.templateArgumentParser = templateArgumentParser
        self.templateRenderer = templateRenderer
        self.contextBuilder = contextBuilder
        self.storage = storage
    }
    
    func run(template: String) throws {
        let content: String
        if let templateURL = templateArgumentParser.getTemplateName(template: template) {
            content = try templateRenderer.render(
                templateFile: templateURL,
                context: contextBuilder.build()
            )
        } else {
            content = try templateRenderer.render(
                template: podfileTemplate,
                context: contextBuilder.build()
            )
        }
        try storage.saveFile(name: Constant.templateFileName, path: URL(fileURLWithPath: ""), content: content, overwrite: true)
    }
 }
