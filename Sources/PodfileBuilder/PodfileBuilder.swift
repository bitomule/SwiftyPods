import Foundation
import Storage
import SwiftyPodsDSL
import TemplateRenderer

public final class PodfileBuilder {
    private enum Constant {
        static let propertyName = "pods"
    }
    
    private let templateRenderer: TemplateRendering
    
    public init(templateRenderer: TemplateRendering = TemplateRenderer()) {
        self.templateRenderer = templateRenderer
    }
    
    public func buildPodfile(podfiles: [Podfile], path: String) throws {
        // Check folder exists
        let url = URL(fileURLWithPath: path, isDirectory: true)
        let lines = dependenciesLines(from: podfiles)
        let template = try TemplateRenderer().render(
            template: podfileTemplate,
            context: lines
        )
        try FileSystem().saveFile(name: "podfile", path: url, content: template, overwrite: true)
    }
    
    private func dependenciesLines(from podfiles: [Podfile]) -> [String: String] {
        [Constant.propertyName: podfiles.map { $0.render() }.joined(separator: "\n")]
    }
}
