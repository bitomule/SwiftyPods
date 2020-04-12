import Foundation

class TemplateArgumentParser {
    private enum Constant {
        static let defaultTemplateFileName = "podfile"
    }
    private let template: String
    
    init(template: String) {
        self.template = template
    }
    
    func getPath() -> URL {
        var templateURL = URL(fileURLWithPath: template)
        if templateURL.isFileURL {
            templateURL.deleteLastPathComponent()
        }
        return templateURL
    }
    
    func getTemplateName() -> String {
        let templateURL = URL(fileURLWithPath: template)
        guard templateURL.isFileURL else {
            return "\(Constant.defaultTemplateFileName).stencil"
        }
        return "\(templateURL.lastPathComponent).stencil"
    }
}
