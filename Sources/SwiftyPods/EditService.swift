import Foundation
import PackageBuilder
import TemplateLocator

final class EditService {
    private let packageBuilder: PackageBuilding
    private let templatesLocator: TemplateLocating
    
    init(packageBuilder: PackageBuilding = PackageBuilder(),
         templatesLocator: TemplateLocating = TemplateLocator()) {
        self.packageBuilder = packageBuilder
        self.templatesLocator = templatesLocator
    }
    
    func run() throws {
        let baseUrl = URL(fileURLWithPath: "", isDirectory: true)
        let files = try templatesLocator.findTemplates(at: baseUrl)
        try packageBuilder.build(from: baseUrl, files: files)
    }
 }
