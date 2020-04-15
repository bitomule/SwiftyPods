import Foundation
import TemplateLocator

public protocol PackageBuilding {
    func build(from path: URL) throws -> URL
}

public final class PackageBuilder: PackageBuilding {
    // Create temporal path
    // Create package.swift from template
    // Link files to folder using FileSymlinker
    // Open package.swift
    private let templateLocator: TemplateLocating
    private let temporalPathBuilder: TemporalPathBuilding
    private let manifestBuilder: PackageManifestBuilding
    
    public init(
        templateLocator: TemplateLocating = TemplateLocator(),
        temporalPathBuilder: TemporalPathBuilding = TemporalPathBuilder(),
        manifestBuilder: PackageManifestBuilding = PackageManifestBuilder()
    ) {
        self.templateLocator = templateLocator
        self.temporalPathBuilder = temporalPathBuilder
        self.manifestBuilder = manifestBuilder
    }
    
    public func build(from path: URL) throws -> URL {
        let temporalPath = try temporalPathBuilder.build(at: path)
        let files = try templateLocator.findTemplates(at: path)
        try manifestBuilder.build(at: temporalPath)
        return URL(fileURLWithPath: "")
    }
}
