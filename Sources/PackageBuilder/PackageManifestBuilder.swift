import Foundation
import TemplateRenderer
import Storage

public protocol PackageManifestBuilding {
    func build(at path: URL, packageName: String) throws
}

public final class PackageManifestBuilder: PackageManifestBuilding {
    enum Constant {
        static let packageFileName = "Package.swift"
    }
    private let templateRenderer: TemplateRendering
    private let storage: FileSysteming
    
    public init(templateRenderer: TemplateRendering = TemplateRenderer(),
                storage: FileSysteming = FileSystem()) {
        self.templateRenderer = templateRenderer
        self.storage = storage
    }
    
    public func build(at path: URL, packageName: String) throws {
        let content = try templateRenderer.render(template: packageTemplate, context: ["packageName": packageName])
        try storage.saveFile(name: Constant.packageFileName, path: path, content: content, overwrite: true)
    }
}
