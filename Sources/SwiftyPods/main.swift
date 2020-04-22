import ArgumentParser

struct SwiftyPods: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage podfile",
        subcommands: [
            Generate.self,
            Edit.self,
            Create.self
    ])

    init() { }
}

SwiftyPods.main()
