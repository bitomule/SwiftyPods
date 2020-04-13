import Foundation
import TemplateLocator

public protocol PackageBuilding {
    func build(from path: URL) throws -> URL
}

public final class PackageBuilder: PackageBuilding {
    // Create temporal path
    // Create package.swift from template
    // Files are set in method
    // Link files to folder using FileSymlinker
    private let templateLocator: TemplateLocating
    private let temporalPathBuilder: TemporalPathBuilding
    
    public init(
        templateLocator: TemplateLocating = TemplateLocator(),
        temporalPathBuilder: TemporalPathBuilding = TemporalPathBuilder()
    ) {
        self.templateLocator = templateLocator
        self.temporalPathBuilder = temporalPathBuilder
    }
    
    public func build(from path: URL) throws -> URL {
        let temporalPath = try temporalPathBuilder.build(at: path)
        let files = try templateLocator.findTemplates(at: path)
        print(files)
        return URL(fileURLWithPath: "")
    }
}
