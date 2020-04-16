import Foundation
import TemplateLocator
import SwiftShell

public protocol PackageBuilding {
    func build(from path: URL) throws -> URL
}

public final class PackageBuilder: PackageBuilding {
    // Create temporal path
    // Create package.swift from template
    // Link files to folder using FileSymlinker
    // Open package.swift
    enum Constant {
        static let openCommand = "open"
        static let symlinkCommand = "ln -s"
    }
    private let templateLocator: TemplateLocating
    private let temporalPathBuilder: TemporalPathBuilding
    private let manifestBuilder: PackageManifestBuilding
    private let symlinkBuilder: FileSymlinking
    
    public init(
        templateLocator: TemplateLocating = TemplateLocator(),
        temporalPathBuilder: TemporalPathBuilding = TemporalPathBuilder(),
        manifestBuilder: PackageManifestBuilding = PackageManifestBuilder(),
        symlinkBuilder: FileSymlinking = FileSimlinker()
    ) {
        self.templateLocator = templateLocator
        self.temporalPathBuilder = temporalPathBuilder
        self.manifestBuilder = manifestBuilder
        self.symlinkBuilder = symlinkBuilder
    }
    
    public func build(from path: URL) throws -> URL {
        let temporalPath = try temporalPathBuilder.build(at: path)
        let files = try templateLocator.findTemplates(at: path)
        let sourcesPath = temporalPath.appendingPathComponent("Sources/").appendingPathComponent("\(Constants.packageName)/")
        try createSourcesPath(sourcesPath: sourcesPath)
        try files.forEach { file in
            let newFilePath = sourcesPath.appendingPathComponent(file.lastPathComponent)
            try symlinkBuilder.linkFile(at: newFilePath, to: file)
        }
        try manifestBuilder.build(at: temporalPath)
        try createMainSwift(sourcesPath: sourcesPath)
        open(url: temporalPath)
        waitForUserEnter(temporalPath: temporalPathBuilder.getRootTemporalPath())
        return URL(fileURLWithPath: "")
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
    
    private func waitForUserEnter(temporalPath: String) {
        print("Opening Package.swift. Press any key to delete temporal package")
        var ended = false
        while !ended, let _ = main.stdin.readSome() {
            ended = true
            deleteTempFolder(path: temporalPath)
        }
    }
    
    private func deleteTempFolder(path: String) {
        try? FileManager.default.removeItem(atPath: path)
    }
}
