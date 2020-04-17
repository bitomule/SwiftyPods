import Foundation
import Storage

public protocol PackageBuilding {
    @discardableResult
    func build(from path: URL, files: [URL]) throws -> URL
    func finish(originalFiles: [URL], path: URL) throws
}

public final class PackageBuilder: PackageBuilding {
    private let temporalPathBuilder: TemporalPathBuilding
    private let manifestBuilder: PackageManifestBuilding
    private let templateFilesManager: TemplateFilesCoping
    private let storage: FileSysteming
    private let packageName: String
    
    public init(
        temporalPathBuilder: TemporalPathBuilding = TemporalPathBuilder(),
        manifestBuilder: PackageManifestBuilding = PackageManifestBuilder(),
        templateFilesManager: TemplateFilesCoping = TemplateFilesManager(),
        storage: FileSysteming = FileSystem(),
        packageName: String
    ) {
        self.temporalPathBuilder = temporalPathBuilder
        self.manifestBuilder = manifestBuilder
        self.templateFilesManager = templateFilesManager
        self.storage = storage
        self.packageName = packageName
    }
    
    @discardableResult
    public func build(from path: URL, files: [URL]) throws -> URL {
        let temporalPath = try temporalPathBuilder.build(at: path)
        let sourcesPath = temporalPath.appendingPathComponent("Sources/").appendingPathComponent("\(packageName)/")
        try createSourcesPath(sourcesPath: sourcesPath)
        try files.forEach { file in
            let newFilePath = sourcesPath.appendingPathComponent(file.lastPathComponent)
            try templateFilesManager.copyTemplate(from: file, to: newFilePath)
        }
        try manifestBuilder.build(at: temporalPath, packageName: packageName)
        try createMainSwift(sourcesPath: sourcesPath)
        return temporalPath
    }
    
    public func finish(originalFiles: [URL], path: URL) throws {
        try copyFilesBack(originalFiles: originalFiles, path: path)
        try storage.delete(at: temporalPathBuilder.getRootTemporalPath())
    }
    
    private func copyFilesBack(originalFiles: [URL], path: URL) throws {
        let sourcesPath = path.appendingPathComponent("Sources/").appendingPathComponent("\(packageName)/")
        try originalFiles.forEach { file in
            let newFilePath = sourcesPath.appendingPathComponent(file.lastPathComponent)
            try templateFilesManager.copyTemplate(from: newFilePath, to: file)
        }
    }
    
    private func createSourcesPath(sourcesPath: URL) throws {
        try FileManager.default.createDirectory(atPath: sourcesPath.relativePath, withIntermediateDirectories: true, attributes: nil)
    }
    
    private func createMainSwift(sourcesPath: URL) throws {
        let fileUrl = sourcesPath.appendingPathComponent("main.swift")
        FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    }
}
