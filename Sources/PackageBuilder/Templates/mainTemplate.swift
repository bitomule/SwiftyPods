let mainTemplate = """
import Foundation
import ArgumentParser
import PodsDSL
import PodfileBuilder

let podfiles = [{{podfiles}}]

struct Generate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generate podfile")

    @Argument(help: "Path where podfile will be generated")
    private var path: String
        
    func run() throws {
        try buildPodfile(podfiles: podfiles, path: path)
    }
}

Generate.main()
"""
