import Foundation

final class PodfileBuilder {
    private let templateArgumentParser = TemplateArgumentParser()
    private let templateRenderer = TemplateRenderer()
    private let contextBuilder: TemplateContextBuilder = ContentBuilder()
    
    func build(template: String, workspaceName: String) throws {
        try templateRenderer.render(
            templatePath: templateArgumentParser.getPath(template: template),
            templateFileName: templateArgumentParser.getTemplateName(template: template),
            context: getContext(workspaceName: workspaceName),
            targetPath: URL(fileURLWithPath: "")
        )
    }
    
    private func getContext(workspaceName: String) -> [String: String] {
        contextBuilder
        .setWorkSpaceName(workspaceName)
        .build()
    }
 }
