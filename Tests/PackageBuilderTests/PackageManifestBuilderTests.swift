import XCTest
import class Foundation.Bundle
@testable import PackageBuilder
import TemplateRenderer
import Storage

final class PackageManifestBuilderTests: XCTestCase {
    private var manifestBuilder: PackageManifestBuilder!
    
    func testSavesManifest() throws {
        let templateRendererMock = TemplateRendererMock()
        templateRendererMock.rendered = "Rendered"
        let fileSystemMock = FileSystemMock()
        manifestBuilder = PackageManifestBuilder(templateRenderer: templateRendererMock,
                                                 storage:fileSystemMock)
        try manifestBuilder.build(at: URL(fileURLWithPath: "packagePath"), packageName: "TestPackage", template: "")
        XCTAssertNotNil(fileSystemMock.saveFileArguments)
        XCTAssertEqual(fileSystemMock.saveFileArguments!.name, "Package.swift")
        XCTAssertEqual(fileSystemMock.saveFileArguments!.path.relativePath, "packagePath")
        XCTAssertEqual(fileSystemMock.saveFileArguments!.content, "Rendered")
        XCTAssertTrue(fileSystemMock.saveFileArguments!.overwrite)
    }


    static var allTests = [
        ("testSavesManifest", testSavesManifest)
    ]
}

// MARK: - Mocks

private final class TemplateRendererMock: TemplateRendering {
    var rendered: String = ""
    
    func render(
        template: String,
        context: [String: String]
    ) throws -> String {
        rendered
    }
    
    func render(
        templateFile: URL,
        context: [String: String]
    ) throws -> String {
        rendered
    }
}

private final class FileSystemMock: FileSysteming {
    struct SaveFileArguments {
        let name: String
        let path: URL
        let content: String
        let overwrite: Bool
    }
    var saveFileArguments: SaveFileArguments?
    
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws {
        saveFileArguments = SaveFileArguments(name: name, path: path, content: content, overwrite: overwrite)
    }
    
    func getFile(at: URL) throws -> String {
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
}
