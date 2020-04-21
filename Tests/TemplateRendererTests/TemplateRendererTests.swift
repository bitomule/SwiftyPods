import XCTest
import class Foundation.Bundle
import TemplateRenderer
import Storage

final class TemplateRendererTests: XCTestCase {
    private var templateRenderer: TemplateRenderer!
    
    func testGeneratesfromString() throws {
        templateRenderer = TemplateRenderer(storage: FileSystemMock())
        let expectedTemplate = "Hello David"
        let generatedTemplate = try templateRenderer.render(template: "Hello {{name}}", context: ["name": "David"])

        XCTAssertEqual(generatedTemplate, expectedTemplate)
    }
    
    func testGeneratesfromFile() throws {
        let storageMock = FileSystemMock()
        storageMock.fileContent = "Hello {{name}}"
        templateRenderer = TemplateRenderer(storage: storageMock)
        let expectedTemplate = "Hello David"
        let generatedTemplate = try templateRenderer.render(templateFile: URL(fileURLWithPath: ""), context: ["name": "David"])

        XCTAssertEqual(generatedTemplate, expectedTemplate)
    }

    static var allTests = [
        ("testGeneratesfromString", testGeneratesfromString),
        ("testGeneratesfromFile", testGeneratesfromFile)
    ]
}

// MARK: - Mocks

private final class FileSystemMock: FileSysteming {
    var fileContent: String?
    
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws {
        fatalError()
    }
    
    func getFile(at: URL) throws -> String {
        if let fileContent = fileContent {
            return fileContent
        }
        fatalError()
    }
    
    func copyFile(from: URL, to: URL, override: Bool) throws {
        fatalError()
    }
    
    func delete(at path: String) throws {
        fatalError()
    }
    
    func createFolder(at url:URL) throws {
        fatalError()
    }
    
    func findFilesInFolder(at url: URL, matching: (URL) -> Bool) throws -> [URL] {
        []
    }
}
