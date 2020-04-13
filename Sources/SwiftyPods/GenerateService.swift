import Foundation

final class GenerateService {
    private let templateArgumentParser = TemplateArgumentParser()
    private let templateRenderer = TemplateRenderer()
    private let contextBuilder: TemplateContextBuilder = ContentBuilder()
    
    func run(template: String) throws {
        try templateRenderer.render(
            templatePath: templateArgumentParser.getPath(template: template),
            templateFileName: templateArgumentParser.getTemplateName(template: template),
            context: contextBuilder.build(),
            targetPath: URL(fileURLWithPath: "")
        )
    }
 }
