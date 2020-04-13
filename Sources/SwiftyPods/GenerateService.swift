import Foundation
import StencilTemplateRenderer

final class GenerateService {
    private enum Constant {
        static let templateFileName = "podfile"
    }
    private let templateArgumentParser: TemplateArgumentParser
    private let templateRenderer: StencilTemplateRendering
    private let contextBuilder: TemplateContextBuilder
    
    init(
        templateArgumentParser: TemplateArgumentParser = TemplateArgumentParser(),
        templateRenderer: StencilTemplateRendering = StencilTemplateRenderer(),
        contextBuilder: TemplateContextBuilder = ContentBuilder()
    ) {
        self.templateArgumentParser = templateArgumentParser
        self.templateRenderer = templateRenderer
        self.contextBuilder = contextBuilder
    }
    
    func run(template: String) throws {
        try templateRenderer.render(
            templatePath: templateArgumentParser.getPath(template: template),
            templateFileName: templateArgumentParser.getTemplateName(template: template),
            context: contextBuilder.build(),
            targetName: Constant.templateFileName,
            targetPath: URL(fileURLWithPath: "")
        )
    }
 }
