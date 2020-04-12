import Foundation

protocol TemplateContextBuilder {
    func build() -> [String: String]
}

final class ContentBuilder: TemplateContextBuilder {
    enum Constant {
        static let propertyName = "pods"
    }
    
    func build() -> [String: String] {
        let lines = podfile.targets.map {
            $0.dependencies.map {
                $0.toString()
            }.joined(separator: "\n")
        }
        .joined(separator: "\n")
        return [
            Constant.propertyName: lines
        ]
    }
}
