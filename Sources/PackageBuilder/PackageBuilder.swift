import Foundation
import SwiftShell

public protocol PackageBuilding {
    @discardableResult
    func build(from path: URL, files: [URL]) throws -> URL
    func cleanTemporalFolder()
}

public final class PackageBuilder: PackageBuilding {
    enum Constant {
        static let openCommand = "open"
    }
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
    public func build(from path: URL, files: [URL]) throws -> URL {
        let temporalPath = try temporalPathBuilder.build(at: path)
        let sourcesPath = temporalPath.appendingPathComponent("Sources/").appendingPathComponent("\(Constants.packageName)/")
        try createSourcesPath(sourcesPath: sourcesPath)
        try files.forEach { file in
            let newFilePath = sourcesPath.appendingPathComponent(file.lastPathComponent)
            try symlinkBuilder.linkFile(at: newFilePath, to: file)
        }
        try manifestBuilder.build(at: temporalPath)
        try createMainSwift(sourcesPath: sourcesPath)
        open(url: temporalPath)
        return temporalPath
    }
    
    public func cleanTemporalFolder() {
        try? FileManager.default.removeItem(atPath: temporalPathBuilder.getRootTemporalPath())
    }
    
    private func open(url: URL) {
        let packageURL = url.appendingPathComponent(Constants.packageFileName)
        run(Constant.openCommand, packageURL.relativeString)
    }
    
    private func createSourcesPath(sourcesPath: URL) throws {
        try FileManager.default.createDirectory(atPath: sourcesPath.relativePath, withIntermediateDirectories: true, attributes: nil)
    }
    
    private func createMainSwift(sourcesPath: URL) throws {
        let fileUrl = sourcesPath.appendingPathComponent("main.swift")
        FileManager.default.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    }
}
