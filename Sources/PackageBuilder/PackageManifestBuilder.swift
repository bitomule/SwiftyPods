import Foundation
import TemplateRenderer

public protocol PackageManifestBuilding {
    func build(at path: URL) throws
}

public final class PackageManifestBuilder: PackageManifestBuilding {
    private let templateRenderer: TemplateRendering
    
    public init(templateRenderer: TemplateRendering = TemplateRenderer()) {
        self.templateRenderer = templateRenderer
    }
    
    public func build(at path: URL) throws {
        try templateRenderer.render(template: packageTemplate, context: ["packageName": Constants.packageName], targetName: Constants.packageFileName, targetPath: path)
    }
}
