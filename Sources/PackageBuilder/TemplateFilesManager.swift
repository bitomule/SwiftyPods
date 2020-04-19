import Foundation
import Storage

protocol TemplateFilesCoping {
    func copyTemplate(from: URL, to: URL, override: Bool) throws
    func restoreTemplate(from: URL, to: URL) throws
    func getTemplateNameFrom(url: URL) throws -> String
}

final class TemplateFilesManager: TemplateFilesCoping {
    enum Constant {
        static let defaultFileName = "podfile"
        static let fileExtension = ".swift"
    }
    
    private let storage: FileSysteming
    
    init (storage: FileSysteming = FileSystem()) {
        self.storage = storage
    }
    
    func copyTemplate(from: URL, to: URL, override: Bool) throws {
        try storage.copyFile(from: from, to: buildTemplateURLFromPropertyName(url: to, originalFile: from), override: override)
    }
    
    func restoreTemplate(from: URL, to: URL) throws {
        try storage.copyFile(from: buildTemplateURLFromPropertyName(url: from, originalFile: to), to: to, override: true)
    }
    
    func getTemplateNameFrom(url: URL) throws -> String {
        try findNameForFile(at: url)
    }
    
    private func buildTemplateURLFromPropertyName(url: URL, originalFile: URL) throws -> URL {
        let nameForTarget = try findNameForFile(at: originalFile) + Constant.fileExtension
        let targetUrl = url.deletingLastPathComponent()
        return targetUrl.appendingPathComponent(nameForTarget)
    }
    
    private func findNameForFile(at url: URL) throws -> String {
        let content = try storage.getFile(at: url)
        return try getNameFromContent(content: content) ?? Constant.defaultFileName
    }
    
    private func getNameFromContent(content: String) throws -> String? {
        return try match(for: #"let ([^\s]+)\s?=\s?Podfile"#, in: content)
    }
    
    private func match(for regex: String, in text: String) throws -> String? {
        let regex = try NSRegularExpression(pattern: regex)
        guard let wholeMatch = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
            let matchRange = Range(wholeMatch.range(at: 1), in: text) else {
            return nil
        }
        return String(text[matchRange])
    }
}
