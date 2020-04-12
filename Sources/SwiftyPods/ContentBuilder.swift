import Foundation

protocol TemplateContextBuilder {
    func setWorkSpaceName(_ workspaceName: String) -> Self
    func build() -> [String: String]
}

final class ContentBuilder: TemplateContextBuilder {
    private enum Constant {
        static let defaultWorkspaceName = "WorkspaceName"
    }
    private var workspaceName: String?
    
    func setWorkSpaceName(_ workspaceName: String) -> Self {
        self.workspaceName = workspaceName
        return self
    }
    
    func build() -> [String: String] {
        return [
            "workspaceName": workspaceName ?? Constant.defaultWorkspaceName,
            "pods": "hello"
        ]
    }
}
