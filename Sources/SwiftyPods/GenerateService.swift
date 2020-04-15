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

private let podfileTemplate = """
platform :ios, '13.0'
inhibit_all_warnings!

{{ pods }}
"""
