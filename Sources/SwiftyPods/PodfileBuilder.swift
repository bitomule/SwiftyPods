import Foundation

final class PodfileBuilder {
    private let templateArgumentParser = TemplateArgumentParser()
    private let templateRenderer = TemplateRenderer()
    private let contextBuilder: TemplateContextBuilder = ContentBuilder()
    
    func build(template: String) throws {
        try templateRenderer.render(
            templatePath: templateArgumentParser.getPath(template: template),
            templateFileName: templateArgumentParser.getTemplateName(template: template),
            context: contextBuilder.build(),
            targetPath: URL(fileURLWithPath: "")
        )
    }
 }
