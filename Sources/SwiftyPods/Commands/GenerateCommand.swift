import ArgumentParser
import Stencil
import Foundation
import PathKit

struct GenerateCommand: ParsableCommand {
    
    public static let configuration = CommandConfiguration(abstract: "Generate a pod file from template")
    
    @Option(name: .shortAndLong, default: "podfile", help: "Optional path to template file")
    private var template: String
    
    private let defaultTemplateFileName = "podfile.stencil"
    
    func run() throws {
        try PodfileBuilder().build(template: template)
    }
}
