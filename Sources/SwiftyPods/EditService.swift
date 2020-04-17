import Foundation
import PackageBuilder
import TemplateLocator
import SwiftShell

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
        waitForUserInput()
    }
    
    private func waitForUserInput() {
        print("Opening Package.swift. Press any key to delete temporal package")
        var ended = false
        while !ended, let _ = main.stdin.readSome() {
            ended = true
            packageBuilder.cleanTemporalFolder()
            print("Project deleted")
        }
    }
}
