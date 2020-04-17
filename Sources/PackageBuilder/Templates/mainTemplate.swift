let mainTemplate = """
import Foundation
import ArgumentParser
import PodsDSL
import PodfileBuilder

let podfiles = [{{podfiles}}]

struct Generate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Open templates in folder to edit")
        
    func run() throws {
        buildPodfile(podfiles: podfiles)
    }
}

struct DSLBuilder: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage podfile",
        subcommands: [
            Generate.self
    ])

    init() { }
}

DSLBuilder.main()
"""
