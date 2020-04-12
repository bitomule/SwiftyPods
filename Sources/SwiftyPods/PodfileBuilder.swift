import Foundation

final class PodfileBuilder {
    private let templateArgumentParser = TemplateArgumentParser()
    private let templateRenderer = TemplateRenderer()
    
    func build(template: String) throws {
        try templateRenderer.render(
            templatePath: templateArgumentParser.getPath(template: template),
            templateFileName: templateArgumentParser.getTemplateName(template: template),
            context: ["name": "Hola caracola"],
            targetPath: URL(fileURLWithPath: "")
        )
    }
}
