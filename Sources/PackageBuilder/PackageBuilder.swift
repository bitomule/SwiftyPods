import Foundation
import Storage
import SwiftShell
import TemplateRenderer

public protocol PackageBuilding {
    @discardableResult
    func build(from path: URL, files: [URL]) throws -> URL
    func finish(originalFiles: [URL], path: URL) throws
    func buildProject(from path: URL, files: [URL]) throws -> URL
    func clean()
}

public final class PackageBuilder: PackageBuilding {
    private let temporalPathBuilder: TemporalPathBuilding
    private let manifestBuilder: PackageManifestBuilding
    private let templateFilesManager: TemplateFilesCoping
    private let templateRenderer: TemplateRendering
    private let storage: FileSysteming
    private let bash: BashRunning
    private let packageName: String
    private let templateWithCommands: String
    private let templateWithoutCommands: String
    private let mainFileWithCommandsTemplate: String
    
    public convenience init(packageName: String) {
        self.init(
            temporalPathBuilder: TemporalPathBuilder(),
            manifestBuilder: PackageManifestBuilder(),
            templateFilesManager: TemplateFilesManager(),
            templateRenderer: TemplateRenderer(),
            storage: FileSystem(),
            bash: Bash(),
            packageName: packageName,
            templateWithCommands: packageTemplate,
            templateWithoutCommands: dslOnlyPackage,
            mainFileWithCommandsTemplate: mainTemplate)
    }
    
    init(
        temporalPathBuilder: TemporalPathBuilding,
        manifestBuilder: PackageManifestBuilding,
        templateFilesManager: TemplateFilesCoping,
        templateRenderer: TemplateRendering,
        storage: FileSysteming,
        bash: BashRunning,
        packageName: String,
        templateWithCommands: String,
        templateWithoutCommands: String,
        mainFileWithCommandsTemplate: String
    ) {
        self.temporalPathBuilder = temporalPathBuilder
        self.manifestBuilder = manifestBuilder
        self.templateFilesManager = templateFilesManager
        self.templateRenderer = templateRenderer
        self.storage = storage
        self.bash = bash
        self.packageName = packageName
        self.templateWithCommands = templateWithCommands
        self.templateWithoutCommands = templateWithoutCommands
        self.mainFileWithCommandsTemplate = mainFileWithCommandsTemplate
    }
    
    @discardableResult
    public func build(from path: URL, files: [URL]) throws -> URL {
        let temporalPath = try createBasicPackage(path: path, files: files, manifestTemplate: templateWithCommands)
        try createMainSwift(sourcesPath: temporalPath, files: files)
        return temporalPath
    }
    
    public func buildProject(from path: URL, files: [URL]) throws -> URL {
        let temporalPath = try createBasicPackage(path: path, files: files, manifestTemplate: templateWithoutCommands)
        try createEmptyMainSwift(sourcesPath: temporalPath, files: files)
        print("Generating temporal project. This may take a few seconds...\n")
        bash.run(bash: "(cd \(temporalPath.path) && swift package generate-xcodeproj)")
        return temporalPath
    }
    
    public func finish(originalFiles: [URL], path: URL) throws {
        try copyFilesBack(originalFiles: originalFiles, path: path)
        try storage.delete(at: temporalPathBuilder.getRootTemporalPath())
    }
    
    public func clean() {
        try? storage.delete(at: temporalPathBuilder.getRootTemporalPath())
    }
    
    private func createBasicPackage(path: URL, files: [URL], manifestTemplate: String) throws -> URL {
        let temporalPath = try temporalPathBuilder.build(at: path)
        try files.forEach { file in
            let newFilePath = temporalPath.appendingPathComponent(file.lastPathComponent)
            try templateFilesManager.copyTemplate(from: file, to: newFilePath, override: false)
        }
        try manifestBuilder.build(at: temporalPath, packageName: packageName, template: manifestTemplate)
        return temporalPath
    }
    
    private func copyFilesBack(originalFiles: [URL], path: URL) throws {
        try originalFiles.forEach { file in
            let newFilePath = path.appendingPathComponent(file.lastPathComponent)
            try templateFilesManager.restoreTemplate(from: newFilePath, to: file)
        }
    }
    
    private func createMainSwift(sourcesPath: URL, files: [URL]) throws {
        let fileNames = try files.map { try templateFilesManager.getTemplateNameFrom(url: $0) }
        let mainContent = try templateRenderer.render(template: mainFileWithCommandsTemplate, context: ["podfiles": fileNames.joined(separator: ", ")])
        try storage.saveFile(name: "main.swift", path: sourcesPath, content: mainContent, overwrite: true)
    }
    
    private func createEmptyMainSwift(sourcesPath: URL, files: [URL]) throws {
        try storage.saveFile(name: "main.swift", path: sourcesPath, content: "", overwrite: true)
    }
}
