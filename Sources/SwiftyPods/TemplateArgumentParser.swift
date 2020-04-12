import Foundation

class TemplateArgumentParser {
    private enum Constant {
        static let defaultTemplateFileName = "podfile"
    }
    
    func getPath(template: String) -> URL {
        var templateURL = URL(fileURLWithPath: template)
        if templateURL.isFileURL {
            templateURL.deleteLastPathComponent()
        }
        return templateURL
    }
    
    func getTemplateName(template: String) -> String {
        let templateURL = URL(fileURLWithPath: template)
        guard templateURL.isFileURL else {
            return "\(Constant.defaultTemplateFileName).stencil"
        }
        return "\(templateURL.lastPathComponent).stencil"
    }
}
