import ArgumentParser

struct Generate: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generate a pod file from template")

    @Argument(help: "The path to template file")
    private var template: String

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool

    func run() throws {
        if verbose {
            print("Generating pod file")
        }
    }
}
