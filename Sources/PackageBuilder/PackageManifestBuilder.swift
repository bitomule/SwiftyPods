import Foundation
import TemplateRenderer
import Storage

protocol PackageManifestBuilding {
    func build(at path: URL, packageName: String, template: String) throws
}

public final class PackageManifestBuilder: PackageManifestBuilding {
    enum Constant {
        static let packageFileName = "Package.swift"
    }
    private let templateRenderer: TemplateRendering
    private let storage: FileSysteming
    
    init(templateRenderer: TemplateRendering = TemplateRenderer(),
                storage: FileSysteming = FileSystem()) {
        self.templateRenderer = templateRenderer
        self.storage = storage
    }
    
    func build(at path: URL, packageName: String, template: String) throws {
        let content = try templateRenderer.render(template: template, context: ["packageName": packageName])
        try storage.saveFile(name: Constant.packageFileName, path: path, content: content, overwrite: true)
    }
}
