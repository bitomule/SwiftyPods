import XCTest
import class Foundation.Bundle
@testable import PodfileBuilder
import Storage
import TemplateRenderer

final class PodfileBuilderTests: XCTestCase {
    private var podfileBuilder: PodfileBuilder!
    
    func testSavesGeneratedEmptyPodfile() throws {
        let fileSystemMock = FileSystemMock()
        let templateRenderMock = TemplateRenderingMock()
        let defaultTemplate = "content{{pods}}"
        podfileBuilder = PodfileBuilder(templateRenderer: templateRenderMock, storage: fileSystemMock, defaultTemplate: defaultTemplate)
        
        try podfileBuilder.buildPodfile(podfiles: [], path: "path")
        
        XCTAssertNotNil(fileSystemMock.saveFileArguments)
        XCTAssertNotNil(templateRenderMock.renderArguments)
        XCTAssertEqual(fileSystemMock.saveFileArguments!.name, "podfile")
        XCTAssertEqual(templateRenderMock.renderArguments!.context["pods"], "")
        XCTAssertEqual(templateRenderMock.renderArguments!.template, defaultTemplate)
    }
    
    func testSavesGeneratedPodfileFromFile() throws {
        let fileSystemMock = FileSystemMock()
        let fileTemplate = "fileTemplate{{pods}}"
        fileSystemMock.getFile = fileTemplate
        let templateRenderMock = TemplateRenderingMock()
        let defaultTemplate = "content{{pods}}"
        podfileBuilder = PodfileBuilder(templateRenderer: templateRenderMock, storage: fileSystemMock, defaultTemplate: defaultTemplate)
        
        try podfileBuilder.buildPodfile(podfiles: [], path: "path", templatePath: "path")
        
        XCTAssertNotNil(fileSystemMock.saveFileArguments)
        XCTAssertNotNil(templateRenderMock.renderArguments)
        XCTAssertEqual(fileSystemMock.saveFileArguments!.name, "podfile")
        XCTAssertEqual(templateRenderMock.renderArguments!.context["pods"], "")
        XCTAssertEqual(templateRenderMock.renderArguments!.template, fileTemplate)
    }

    static var allTests = [
        ("testSavesGeneratedEmptyPodfile", testSavesGeneratedEmptyPodfile)
    ]
}

// MARK: - Mocks

private final class FileSystemMock: FileSysteming {
    struct SaveFileArguments {
        let name: String
        let path: URL
        let content: String
        let overwrite: Bool
    }
    var saveFileArguments: SaveFileArguments?
    
    var getFile: String?
    
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws {
        saveFileArguments = SaveFileArguments(name: name, path: path, content: content, overwrite: overwrite)
    }
    
    func getFile(at: URL) throws -> String {
        getFile ?? ""
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

private final class TemplateRenderingMock: TemplateRendering {
    struct RenderArguments {
        let template: String
        let context: [String: String]
    }
    var renderArguments: RenderArguments?
    
    func render(
        template: String,
        context: [String: String]
    ) throws -> String {
        renderArguments = RenderArguments(template: template, context: context)
        return ""
    }
    
    func render(
        templateFile: URL,
        context: [String: String]
    ) throws -> String {
        ""
    }
}
