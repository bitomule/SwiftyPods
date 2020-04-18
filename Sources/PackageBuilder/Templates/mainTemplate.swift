let mainTemplate = #"""
import Foundation
import ArgumentParser
import SwiftyPodsDSL

let podfiles = [{{podfiles}}]

struct Generate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generate podfile")

    @Argument(help: "Path where podfile will be generated")
    private var path: String
        
    func run() throws {
        try buildPodfile(podfiles: podfiles, path: path)
    }
}

// MARK: - Code required to generate template

func buildPodfile(podfiles: [Podfile], path: String) throws {
    // Check folder exists
    let url = URL(fileURLWithPath: path, isDirectory: true)
    let context = FixedContentBuilder().build(podfiles: podfiles)
    let template = try FixedTemplateRenderer().render(
        template: podfileTemplate,
        context: context
    )
    try saveFile(name: "podfile", path: url, content: template)
}

private func saveFile(name: String, path: URL, content: String) throws {
    let newFile = path.appendingPathComponent(name).path
    FileManager.default.createFile(atPath: newFile, contents: content.data(using: .utf8), attributes: nil)
}

private final class FixedContentBuilder {
    enum Constant {
        static let propertyName = "pods"
    }
    
    func build(podfiles: [Podfile]) -> [String: String] {
        let lines = podfiles.map {
            $0.targets.map {
                $0.dependencies.map {
                    $0.toString()
                }.joined(separator: "\n")
            }
            .joined(separator: "\n")
        }.joined(separator: "\n")
        return [
            Constant.propertyName: lines
        ]
    }
}

private final class FixedTemplateRenderer {
    enum Constant {
        static let fileName = "podfile"
    }
    
    public func render(
        template: String,
        context: [String: String]
    ) throws -> String {
        context.reduce(template) { result, dict in
            return generateFile(template: result, value: dict.value, keyToReplace: dict.key)
        }
    }
    
    public func render(
        templateFile: URL,
        context: [String: String]
    ) throws -> String {
        let template = try String(contentsOf: templateFile)
        return context.reduce(template) { result, dict in
            return generateFile(template: result, value: dict.value, keyToReplace: dict.key)
        }
    }
    
    private func generateFile(template: String, value: String, keyToReplace: String) -> String {
        template.replacingOccurrences(of: "{{\(keyToReplace)}}", with: value)
    }
    
    private func filePath(from url: URL) -> String {
        url.deletingLastPathComponent().relativeString
    }
    
    private func fileName(from url: URL) -> String {
        url.lastPathComponent
    }
}

let podfileTemplate = """
platform :ios, '13.0'
inhibit_all_warnings!

{{pods}}
"""

Generate.main()
"""#
