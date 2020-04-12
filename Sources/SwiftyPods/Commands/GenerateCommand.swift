import ArgumentParser
import Stencil
import Foundation
import PathKit

struct Generate: ParsableCommand {
    
    public static let configuration = CommandConfiguration(abstract: "Generate a pod file from template")
    
    @Option(name: .shortAndLong, default: "podfile", help: "Optional path to template file")
    private var template: String
    
    @Option(name: .shortAndLong, default: "defaultWorkspace", help: "Optional path to template file")
    private var workspaceName: String
    
    private let defaultTemplateFileName = "podfile.stencil"
    
    func run() throws {
        try PodfileBuilder().build(template: template, workspaceName: workspaceName)
    }
}