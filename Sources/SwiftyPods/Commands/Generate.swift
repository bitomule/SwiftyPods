import ArgumentParser
import Stencil
import Foundation
import PathKit

struct Generate: ParsableCommand {
    
    public static let configuration = CommandConfiguration(abstract: "Generate a pod file from template")
    
    @Option(name: .shortAndLong, default: "podfile", help: "Optional path to template file")
    private var template: String
    
    private let defaultTemplateFileName = "podfile.stencil"
            
    func run() throws {
        let templateParser = TemplateParser(template: template)
        let fsLoader = FileSystemLoader(paths: [templateParser.getPath()])
        let environment = Environment(loader: fsLoader)
        
        let context = ["name": "Hola caracola"]
        let content = try environment.renderTemplate(name: templateParser.getTemplateName(), context: context)
        try DiskDataSource().saveFile(name: "podfile", path: URL(fileURLWithPath: ""), content: content, overwrite: true)
    }
}
