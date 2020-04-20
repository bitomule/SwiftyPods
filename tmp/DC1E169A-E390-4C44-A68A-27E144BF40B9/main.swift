import Foundation
import ArgumentParser
import SwiftyPodsDSL
import PodfileBuilder

let podfiles = [example]

struct Generate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generate podfile")

    @Argument(help: "Path where podfile will be generated")
    private var path: String
        
    func run() throws {
        try PodfileBuilder().buildPodfile(podfiles: podfiles, path: path)
    }
}

Generate.main()