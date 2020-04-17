import Foundation
import TemplateRenderer

public protocol PackageManifestBuilding {
    func build(at path: URL, packageName: String) throws
}

public final class PackageManifestBuilder: PackageManifestBuilding {
    enum Constant {
        static let packageFileName = "Package.swift"
    }
    private let templateRenderer: TemplateRendering
    
    public init(templateRenderer: TemplateRendering = TemplateRenderer()) {
        self.templateRenderer = templateRenderer
    }
    
    public func build(at path: URL, packageName: String) throws {
        try templateRenderer.render(template: packageTemplate, context: ["packageName": packageName], targetName: Constant.packageFileName, targetPath: path)
    }
}
