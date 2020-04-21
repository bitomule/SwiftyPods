import Foundation
import Storage

class TemplateArgumentParser {
    private let storage: FileSysteming
    
    init(storage: FileSysteming = FileSystem()) {
        self.storage = storage
    }
    
    func getTemplateName(template: String) -> URL? {
        let templateURL = URL(fileURLWithPath: template)
        guard storage.fileExists(at: templateURL) else {
            return nil
        }
        return templateURL
    }
}
