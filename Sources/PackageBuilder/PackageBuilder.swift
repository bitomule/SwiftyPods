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
    
    public init(templateLocator: TemplateLocating = TemplateLocator()) {
        self.templateLocator = templateLocator
    }
    
    public func build(from path: URL) throws -> URL {
        let temporalPath = URL(fileURLWithPath: "", isDirectory: true)
        let files = try templateLocator.findTemplates(at: path)
        print(files)
        return URL(fileURLWithPath: "")
    }
}
