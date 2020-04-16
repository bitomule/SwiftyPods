import Foundation
import TemplateRenderer

final class GenerateService {
    private enum Constant {
        static let templateFileName = "podfile"
    }
    private let templateArgumentParser: TemplateArgumentParser
    private let templateRenderer: TemplateRendering
    private let contextBuilder: TemplateContextBuilder
    
    init(
        templateArgumentParser: TemplateArgumentParser = TemplateArgumentParser(),
        templateRenderer: TemplateRendering = TemplateRenderer(),
        contextBuilder: TemplateContextBuilder = ContentBuilder()
    ) {
        self.templateArgumentParser = templateArgumentParser
        self.templateRenderer = templateRenderer
        self.contextBuilder = contextBuilder
    }
    
    func run(template: String) throws {
        if let templateURL = templateArgumentParser.getTemplateName(template: template) {
            try templateRenderer.render(
                templateFile: templateURL,
                context: contextBuilder.build(),
                targetName: Constant.templateFileName,
                targetPath: URL(fileURLWithPath: "")
            )
        } else {
            try templateRenderer.render(
                template: podfileTemplate,
                context: contextBuilder.build(),
                targetName: Constant.templateFileName,
                targetPath: URL(fileURLWithPath: "")
            )
        }
        
    }
 }
