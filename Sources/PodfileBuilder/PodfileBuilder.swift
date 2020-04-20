import Foundation
import Storage
import SwiftyPodsDSL
import TemplateRenderer

public final class PodfileBuilder {
    private enum Constant {
        static let propertyName = "pods"
    }
    
    private let templateRenderer: TemplateRendering
    private let storage: FileSysteming
    private let defaultTemplate: String
    
    public convenience init() {
        self.init(templateRenderer: TemplateRenderer(), storage: FileSystem(), defaultTemplate: podfileTemplate)
    }
    
    init(templateRenderer: TemplateRendering,
                storage: FileSysteming,
                defaultTemplate: String) {
        self.templateRenderer = templateRenderer
        self.storage = storage
        self.defaultTemplate = defaultTemplate
    }
    
    public func buildPodfile(podfiles: [Podfile], path: String, templatePath: String? = nil) throws {
        let url = URL(fileURLWithPath: path, isDirectory: true)
        let lines = dependenciesLines(from: podfiles)
        let template = try templateRenderer.render(
            template: try loadTemplateFromPath(templatePath) ?? defaultTemplate,
            context: lines
        )
        try storage.saveFile(name: "podfile", path: url, content: template, overwrite: true)
    }
    
    private func loadTemplateFromPath(_ path: String?) throws -> String? {
        guard let path = path else { return nil }
        return try storage.getFile(at: URL(fileURLWithPath: path))
    }
    
    private func dependenciesLines(from podfiles: [Podfile]) -> [String: String] {
        [Constant.propertyName: podfiles.map { $0.render() }.joined(separator: "\n")]
    }
}
