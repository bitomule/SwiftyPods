import Foundation
import TemplateLocator

protocol PackageBuilding {
    
}

final class PackageBuilder {
    // Create temporal path
    // Create package.swift from template
    // Files are set in method
    // Link files to folder using FileSymlinker
    private let templateLocator: TemplateLocating
    
    init(templateLocator: TemplateLocating = TemplateLocator()) {
        self.templateLocator = templateLocator
    }
    
    func build(from path: URL) throws -> URL {
        let temporalPath = URL(fileURLWithPath: "", isDirectory: true)
        let files = try templateLocator.findTemplates(at: path)
        print(files)
        return URL(fileURLWithPath: "")
    }
}
