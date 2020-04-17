import Foundation

public protocol PackageBuilding {
    @discardableResult
    func build(from path: URL, files: [URL], packageName: String) throws -> URL
    func cleanTemporalFolder()
}

public final class PackageBuilder: PackageBuilding {
    private let temporalPathBuilder: TemporalPathBuilding
    private let manifestBuilder: PackageManifestBuilding
    private let symlinkBuilder: FileSymlinking
    
    public init(
        temporalPathBuilder: TemporalPathBuilding = TemporalPathBuilder(),
        manifestBuilder: PackageManifestBuilding = PackageManifestBuilder(),
        symlinkBuilder: FileSymlinking = FileSimlinker()
    ) {
        self.temporalPathBuilder = temporalPathBuilder
        self.manifestBuilder = manifestBuilder
        self.symlinkBuilder = symlinkBuilder
    }
    
    @discardableResult
    public func build(from path: URL, files: [URL], packageName: String) throws -> URL {
        let temporalPath = try temporalPathBuilder.build(at: path)
        let sourcesPath = temporalPath.appendingPathComponent("Sources/").appendingPathComponent("\(packageName)/")
        try createSourcesPath(sourcesPath: sourcesPath)
        try files.forEach { file in
            let newFilePath = sourcesPath.appendingPathComponent(file.lastPathComponent)
            try symlinkBuilder.linkFile(at: newFilePath, to: file)
        }
        try manifestBuilder.build(at: temporalPath, packageName: packageName)
        try createMainSwift(sourcesPath: sourcesPath)
        return temporalPath
    }
    
    public func cleanTemporalFolder() {
        try? FileManager.default.removeItem(atPath: temporalPathBuilder.getRootTemporalPath())
    }
    
    private func createSourcesPath(sourcesPath: URL) throws {
        try FileManager.default.createDirectory(atPath: sourcesPath.relativePath, withIntermediateDirectories: true, attributes: nil)
    }
    
    private func createMainSwift(sourcesPath: URL) throws {
        let fileUrl = sourcesPath.appendingPathComponent("main.swift")
        FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    }
}
