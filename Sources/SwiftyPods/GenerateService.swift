import Foundation
import Storage
import PackageBuilder

final class GenerateService {
    private enum Constant {
        static let templateFileName = "podfile"
        static let packageName = "SwiftyPodsTemporalProject"
    }
    private let templateArgumentParser: TemplateArgumentParser
    private let packageBuilder: PackageBuilding
    private let templatesLocator: TemplateLocating
    
    init(templateArgumentParser: TemplateArgumentParser = TemplateArgumentParser(),
         packageBuilder: PackageBuilding = PackageBuilder(packageName: Constant.packageName),
         templatesLocator: TemplateLocating = TemplateLocator()) {
        self.templateArgumentParser = templateArgumentParser
        self.packageBuilder = packageBuilder
        self.templatesLocator = templatesLocator
    }
    
    func run(template: String) throws {
        let baseUrl = URL(fileURLWithPath: "", isDirectory: true)
        let files = try templatesLocator.findTemplates(at: baseUrl)
        let url = try packageBuilder.build(from: baseUrl, files: files)
        // Run generate
    }
 }
