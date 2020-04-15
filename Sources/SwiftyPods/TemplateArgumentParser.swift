import Foundation

class TemplateArgumentParser {
    private let manager: FileManager
    
    init(manager: FileManager = FileManager.default) {
        self.manager = manager
    }
    
    func getTemplateName(template: String) -> URL? {
        let templateURL = URL(fileURLWithPath: template)
        guard templateURL.isFileURL, manager.fileExists(atPath: templateURL.relativeString) else {
            return nil
        }
        return templateURL
    }
}
