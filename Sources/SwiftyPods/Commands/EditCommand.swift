import ArgumentParser
import Foundation

struct Edit: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Open templates in folder to edit")
        
    func run() throws {
        try EditService().run()
    }
}
