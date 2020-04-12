import ArgumentParser
import Stencil
import Foundation

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
        let fsLoader = FileSystemLoader(paths: [""])
        let environment = Environment(loader: fsLoader)
        
        let context = ["name": "Hola caracola"]
        let content = try environment.renderTemplate(name: "podfile.stencil", context: context)
        createFile(baseUrl: URL(fileURLWithPath: ""), content: content)
    }
    
    private func createFile(baseUrl: URL, content: String) {
        let fileManager = FileManager.default
        let newFile = baseUrl.appendingPathComponent("podfile").path
        
        if(!fileManager.fileExists(atPath:newFile)){            
            fileManager.createFile(atPath: newFile, contents: content.data(using: .utf8), attributes: nil)
        }else{
            print("File is already created")
        }
    }
}
