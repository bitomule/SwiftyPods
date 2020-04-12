import Foundation

final class PodfileBuilder {
    private let templateArgumentParser = { TemplateArgumentParser(template: $0) }
    private let templateRenderer = TemplateRenderer()
    
    func build(template: String) throws {
        let templateParser = templateArgumentParser(template)
        try templateRenderer.render(
            templatePath: templateParser.getPath(),
            templateFileName: templateParser.getTemplateName(),
            context: ["name": "Hola caracola"],
            targetPath: URL(fileURLWithPath: "")
        )
    }
}
