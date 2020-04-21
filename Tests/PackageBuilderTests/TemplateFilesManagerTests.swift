import XCTest
import class Foundation.Bundle
@testable import PackageBuilder
import TemplateRenderer
import Storage

final class TemplateFilesManagerTests: XCTestCase {
    private var templateFilesManager: TemplateFilesManager!
    
    func testCopiesTemplate() throws {
        let fileSystemMock = FileSystemMock()
        templateFilesManager = TemplateFilesManager(storage: fileSystemMock)
        
        try templateFilesManager.copyTemplate(from: URL(fileURLWithPath: "one.swift"), to: URL(fileURLWithPath: "two.swift"), override: true)
        
        XCTAssertNotNil(fileSystemMock.copyFileArguments)
        XCTAssertEqual(fileSystemMock.copyFileArguments!.from.relativePath, "one.swift")
        XCTAssertEqual(fileSystemMock.copyFileArguments!.to.relativePath, "./example.swift")
        XCTAssertTrue(fileSystemMock.copyFileArguments!.override)
    }
    
    func testRestoresTemplate() throws {
        let fileSystemMock = FileSystemMock()
        templateFilesManager = TemplateFilesManager(storage: fileSystemMock)
        
        try templateFilesManager.restoreTemplate(from: URL(fileURLWithPath: "./example.swift"), to: URL(fileURLWithPath: "one.swift"))
        
        XCTAssertNotNil(fileSystemMock.copyFileArguments)
        XCTAssertEqual(fileSystemMock.copyFileArguments!.from.relativePath, "./example.swift")
        XCTAssertEqual(fileSystemMock.copyFileArguments!.to.relativePath, "one.swift")
        XCTAssertTrue(fileSystemMock.copyFileArguments!.override)
    }
    
    func testGetsTemplateNameFromFile() throws {
        let fileSystemMock = FileSystemMock()
        templateFilesManager = TemplateFilesManager(storage: fileSystemMock)
        
        let name = try templateFilesManager.getTemplateNameFrom(url: URL(fileURLWithPath: "one.swift"))
        
        XCTAssertEqual(name, "example")
    }


    static var allTests = [
        ("testCopiesTemplate", testCopiesTemplate),
        ("testRestoresTemplate", testRestoresTemplate),
        ("testGetsTemplateNameFromFile", testGetsTemplateNameFromFile)
    ]
}

// MARK: - Mocks

private final class FileSystemMock: FileSysteming {
    struct CopyFileArguments {
        let from: URL
        let to: URL
        let override: Bool
    }
    var copyFileArguments: CopyFileArguments?
    
    func saveFile(name: String, path: URL, content: String, overwrite: Bool) throws {
        fatalError()
    }
    
    func getFile(at: URL) throws -> String {
        podfileStub
    }
    
    func copyFile(from: URL, to: URL, override: Bool) throws {
        copyFileArguments = CopyFileArguments(from: from, to: to, override: override)
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

private let podfileStub = """
import Foundation
import SwiftyPodsDSL

let example = Podfile(
    targets: [
        .target(
            name: "Target",
            project: "Project",
            dependencies: [
                .dependency(name: "Dependency1"),
                .dependency(name: "Dependency2",
                            version: "1.2.3"),
                .dependency(name: "Dependency3",
                            .git(url: "repo"),
                            .branch(name: "master"))
            ],
            childTargets: [
                .target(name: "ChildTarget", project: "Project2")
            ]
        )
    ]
)
"""
