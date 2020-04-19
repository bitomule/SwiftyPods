import Foundation
import SwiftyPodsDSL

protocol TemplateContextBuilder {
    func build(podfiles: [Podfile]) -> [String: String]
}

final class ContentBuilder: TemplateContextBuilder {
    enum Constant {
        static let propertyName = "pods"
    }
    
    func build(podfiles: [Podfile]) -> [String: String] {
        return [
            Constant.propertyName: podfiles.map { $0.render() }.joined(separator: "\n")
        ]
    }
}
