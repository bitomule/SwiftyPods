import Foundation
import PackageBuilder
import TemplateLocator
import SwiftShell

final class EditService {
    enum Constant {
        static let openCommand = "open"
        static let packageName = "SwiftyPodsTemporalProject"
        static let packageFileName = "Package.swift"
    }
    
    private let packageBuilder: PackageBuilding
    private let templatesLocator: TemplateLocating
    
    init(packageBuilder: PackageBuilding = PackageBuilder(packageName: Constant.packageName),
         templatesLocator: TemplateLocating = TemplateLocator()) {
        self.packageBuilder = packageBuilder
        self.templatesLocator = templatesLocator
    }
    
    func run() throws {
        let baseUrl = URL(fileURLWithPath: "", isDirectory: true)
        let files = try getTemplateFiles()
        let url = try packageBuilder.build(from: baseUrl, files: files)
        open(url: url)
        try waitForUserInput(projectUrl: url, files: files)
    }
    
    private func getTemplateFiles() throws -> [URL] {
        let baseUrl = URL(fileURLWithPath: "", isDirectory: true)
        return try templatesLocator.findTemplates(at: baseUrl)
    }
    
    private func waitForUserInput(projectUrl: URL, files: [URL]) throws {
        print("Opening Package.swift. Press any key to delete temporal package")
        var ended = false
        while !ended, let _ = main.stdin.readSome() {
            ended = true
            try packageBuilder.finish(originalFiles: files, path: projectUrl)
            print("Project deleted")
        }
    }
    
    private func open(url: URL) {
        let packageURL = url.appendingPathComponent(Constant.packageFileName)
        main.run(Constant.openCommand, packageURL.relativeString)
    }
}
