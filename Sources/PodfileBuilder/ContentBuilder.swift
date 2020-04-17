import Foundation
import PodsDSL

protocol TemplateContextBuilder {
    func build(podfiles: [Podfile]) -> [String: String]
}

final class ContentBuilder: TemplateContextBuilder {
    enum Constant {
        static let propertyName = "pods"
    }
    
    func build(podfiles: [Podfile]) -> [String: String] {
        let lines = podfiles.map {
            $0.targets.map {
                $0.dependencies.map {
                    $0.toString()
                }.joined(separator: "\n")
            }
            .joined(separator: "\n")
        }.joined(separator: "\n")
        return [
            Constant.propertyName: lines
        ]
    }
}
