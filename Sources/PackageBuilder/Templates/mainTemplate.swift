let mainTemplate = """
import Foundation
import ArgumentParser
import SwiftyPodsDSL
import PodfileBuilder

let podfiles = [{{podfiles}}]

struct Generate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generate podfile")

    @Argument(help: "Path where podfile will be generated")
    private var path: String

    @Option(name: .shortAndLong, default: nil, help: "Optional path to template file")
    private var templatePath: String?
        
    func run() throws {
        try PodfileBuilder().buildPodfile(podfiles: podfiles, path: path, templatePath: templatePath)
    }
}

Generate.main()
"""

