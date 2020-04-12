import ArgumentParser

struct SwiftyPods: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage podfile",
        subcommands: [GenerateCommand.self])

    init() { }
}

SwiftyPods.main()
