import Foundation
import TemplateRenderer
import Storage

protocol PackageManifestBuilding {
    func build(at path: URL, packageName: String, includingCommandDependencies: Bool) throws
}

public final class PackageManifestBuilder: PackageManifestBuilding {
    enum Constant {
        static let packageFileName = "Package.swift"
    }
    private let templateRenderer: TemplateRendering
    private let storage: FileSysteming
    private let templateWithCommandDependencies: String
    private let templateWithoutCommandDependencies: String
    
    init(templateRenderer: TemplateRendering = TemplateRenderer(),
                storage: FileSysteming = FileSystem(),
                templateWithCommandDependencies: String = packageTemplate,
                templateWithoutCommandDependencies: String = dslOnlyPackage) {
        self.templateRenderer = templateRenderer
        self.storage = storage
        self.templateWithCommandDependencies = templateWithCommandDependencies
        self.templateWithoutCommandDependencies = templateWithoutCommandDependencies
    }
    
    func build(at path: URL, packageName: String, includingCommandDependencies: Bool) throws {
        let template = includingCommandDependencies ? templateWithCommandDependencies : templateWithoutCommandDependencies
        let content = try templateRenderer.render(template: template, context: ["packageName": packageName])
        try storage.saveFile(name: Constant.packageFileName, path: path, content: content, overwrite: true)
    }
}
