import ArgumentParser
import Stencil
import Foundation
import PathKit

struct Edit: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Open templates in folder to edit")
        
    func run() throws {
        try EditService().run()
    }
}
