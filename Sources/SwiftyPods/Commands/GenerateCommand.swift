import ArgumentParser
import Foundation

struct Generate: ParsableCommand {
    
    public static let configuration = CommandConfiguration(abstract: "Generate a pod file from template")
    
    @Option(name: .shortAndLong, default: nil, help: "Optional path to template file")
    private var template: String?
        
    func run() throws {
        try GenerateService().run(template: template)
    }
}
