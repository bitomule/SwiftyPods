import ArgumentParser
import Foundation

struct Create: ParsableCommand {
    
    public static let configuration = CommandConfiguration(abstract: "Create an empty podfile.swift")
    
    @Option(name: .shortAndLong, default: nil, help: "Optional path where podfile.swift should be created")
    private var path: String?
        
    func run() throws {
        try CreateService().run(path: path)
    }
}
