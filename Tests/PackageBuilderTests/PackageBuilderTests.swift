import XCTest
import class Foundation.Bundle
@testable import PackageBuilder
import TemplateRenderer
import Storage

final class PackageBuilderTests: XCTestCase {
    private var packageBuilder: PackageBuilder!
    
    // MARK: - Build
    
    func testBuildCreatesTemporalPath() throws {
        let temporalPathBuilder = TemporalPathBuidingMock()
        packageBuilder = PackageBuilder(
            temporalPathBuilder: temporalPathBuilder,
            manifestBuilder: PackageManifestBuildingMock(),
            templateFilesManager: TemplateFilesCopingMock(),
            templateRenderer: TemplateRenderingMock(),
            storage: FileSystemMock(),
            bash: BashMock(),
            packageName: "packageName",
        templateWithCommands: "",
        templateWithoutCommands: "",
        mainFileWithCommandsTemplate: "")
        
        _ = try packageBuilder.build(from: URL(fileURLWithPath: ""), files: [])
        
        XCTAssertNotNil(temporalPathBuilder.buildArguments)
        XCTAssertEqual(temporalPathBuilder.buildArguments!.path.relativePath, ".")
    }
    
    func testBuildCopiesFiles() throws {
        let templateFilesManager = TemplateFilesCopingMock()
        templateFilesManager.templateName = "TemplateName"
        packageBuilder = PackageBuilder(
            temporalPathBuilder: TemporalPathBuidingMock(),
            manifestBuilder: PackageManifestBuildingMock(),
            templateFilesManager: templateFilesManager,
            templateRenderer: TemplateRenderingMock(),
            storage: FileSystemMock(),
            bash: BashMock(),
            packageName: "packageName",
            templateWithCommands: "",
            templateWithoutCommands: "",
            mainFileWithCommandsTemplate: "")
        
        _ = try packageBuilder.build(from: URL(fileURLWithPath: ""), files: [URL(fileURLWithPath: "aFolder/podfile.swift")])
        
        XCTAssertNotNil(templateFilesManager.copyTemplateArguments)
        XCTAssertEqual(templateFilesManager.copyTemplateArguments!.from.relativePath, "aFolder/podfile.swift")
        XCTAssertEqual(templateFilesManager.copyTemplateArguments!.to.relativePath, "tmp/podfile.swift")
    }
    
    func testBuildCreatesManifest() throws {
        let manifestBuilderMock = PackageManifestBuildingMock()
        packageBuilder = PackageBuilder(
            temporalPathBuilder: TemporalPathBuidingMock(),
            manifestBuilder: manifestBuilderMock,
            templateFilesManager: TemplateFilesCopingMock(),
            templateRenderer: TemplateRenderingMock(),
            storage: FileSystemMock(),
            bash: BashMock(),
            packageName: "packageName",
            templateWithCommands: "templateWithCommands",
            templateWithoutCommands: "templateWithoutCommands",
            mainFileWithCommandsTemplate: "")
        
        _ = try packageBuilder.build(from: URL(fileURLWithPath: ""), files: [URL(fileURLWithPath: "aFolder/podfile.swift")])
        
        XCTAssertNotNil(manifestBuilderMock.buildArguments)
        XCTAssertEqual(manifestBuilderMock.buildArguments!.path.relativePath, "tmp")
        XCTAssertEqual(manifestBuilderMock.buildArguments!.packageName, "packageName")
        XCTAssertEqual(manifestBuilderMock.buildArguments!.template, "templateWithCommands")
    }
    
    func testBuildCreatesCommandsMain() throws {
        let fileSystemMock = FileSystemMock()
        let templateRendererMock = TemplateRenderingMock()
        packageBuilder = PackageBuilder(
            temporalPathBuilder: TemporalPathBuidingMock(),
            manifestBuilder: PackageManifestBuildingMock(),
            templateFilesManager: TemplateFilesCopingMock(),
            templateRenderer: templateRendererMock,
            storage: fileSystemMock,
            bash: BashMock(),
            packageName: "packageName",
            templateWithCommands: "templateWithCommands",
            templateWithoutCommands: "templateWithoutCommands",
            mainFileWithCommandsTemplate: "mainTemplateHere")
        
        _ = try packageBuilder.build(from: URL(fileURLWithPath: ""), files: [URL(fileURLWithPath: "aFolder/podfile.swift")])
        
        XCTAssertNotNil(templateRendererMock.renderArguments)
        XCTAssertEqual(templateRendererMock.renderArguments!.template, "mainTemplateHere")
        XCTAssertNotNil(templateRendererMock.renderArguments!.context["podfiles"])
        
        XCTAssertNotNil(fileSystemMock.saveFileArguments)
        XCTAssertEqual(fileSystemMock.saveFileArguments!.name, "main.swift")
        XCTAssertEqual(fileSystemMock.saveFileArguments!.path.relativePath, "tmp")
        XCTAssertEqual(fileSystemMock.saveFileArguments!.content, "")
        XCTAssertTrue(fileSystemMock.saveFileArguments!.overwrite)
    }
    
    // MARK: - BuildProject
    
    func testBuildProjectCreatesEmptyMain() throws {
        let fileSystemMock = FileSystemMock()
        packageBuilder = PackageBuilder(
            temporalPathBuilder: TemporalPathBuidingMock(),
            manifestBuilder: PackageManifestBuildingMock(),
            templateFilesManager: TemplateFilesCopingMock(),
            templateRenderer: TemplateRenderingMock(),
            storage: fileSystemMock,
            bash: BashMock(),
            packageName: "packageName",
            templateWithCommands: "templateWithCommands",
            templateWithoutCommands: "templateWithoutCommands",
            mainFileWithCommandsTemplate: "")
        
        _ = try packageBuilder.buildProject(from: URL(fileURLWithPath: ""), files: [URL(fileURLWithPath: "aFolder/podfile.swift")])
        
        XCTAssertNotNil(fileSystemMock.saveFileArguments)
        XCTAssertEqual(fileSystemMock.saveFileArguments!.name, "main.swift")
        XCTAssertEqual(fileSystemMock.saveFileArguments!.path.relativePath, "tmp")
        XCTAssertEqual(fileSystemMock.saveFileArguments!.content, "")
        XCTAssertTrue(fileSystemMock.saveFileArguments!.overwrite)
    }
    
    func testBuildProjectCreatesManifest() throws {
        let manifestBuilderMock = PackageManifestBuildingMock()
        packageBuilder = PackageBuilder(
            temporalPathBuilder: TemporalPathBuidingMock(),
            manifestBuilder: manifestBuilderMock,
            templateFilesManager: TemplateFilesCopingMock(),
            templateRenderer: TemplateRenderingMock(),
            storage: FileSystemMock(),
            bash: BashMock(),
            packageName: "packageName",
            templateWithCommands: "templateWithCommands",
            templateWithoutCommands: "templateWithoutCommands",
            mainFileWithCommandsTemplate: "")
        
        _ = try packageBuilder.buildProject(from: URL(fileURLWithPath: ""), files: [URL(fileURLWithPath: "aFolder/podfile.swift")])
        
        XCTAssertNotNil(manifestBuilderMock.buildArguments)
        XCTAssertEqual(manifestBuilderMock.buildArguments!.path.relativePath, "tmp")
        XCTAssertEqual(manifestBuilderMock.buildArguments!.packageName, "packageName")
        XCTAssertEqual(manifestBuilderMock.buildArguments!.template, "templateWithoutCommands")
    }
    
    func testBuildProjectRunsGenerateXcodeProj() throws {
        let bashMock = BashMock()
        packageBuilder = PackageBuilder(
            temporalPathBuilder: TemporalPathBuidingMock(),
            manifestBuilder: PackageManifestBuildingMock(),
            templateFilesManager: TemplateFilesCopingMock(),
            templateRenderer: TemplateRenderingMock(),
            storage: FileSystemMock(),
            bash: bashMock,
            packageName: "packageName",
            templateWithCommands: "templateWithCommands",
            templateWithoutCommands: "templateWithoutCommands",
            mainFileWithCommandsTemplate: "")
        
        let path = try packageBuilder.buildProject(from: URL(fileURLWithPath: ""), files: [URL(fileURLWithPath: "aFolder/podfile.swift")])
        
        XCTAssertNotNil(bashMock.bashArgument)
        XCTAssertEqual(bashMock.bashArgument!, "(cd \(path.path) && swift package generate-xcodeproj)")
    }

    static var allTests = [
        ("testBuildCreatesTemporalPath", testBuildCreatesTemporalPath),
        ("testBuildCopiesFiles", testBuildCopiesFiles),
        ("testBuildCreatesManifest", testBuildCreatesManifest),
        ("testBuildProjectCreatesEmptyMain", testBuildProjectCreatesEmptyMain),
        ("testBuildProjectCreatesManifest", testBuildProjectCreatesManifest),
        ("testBuildCreatesCommandsMain", testBuildCreatesCommandsMain),
        ("testBuildProjectRunsGenerateXcodeProj", testBuildProjectRunsGenerateXcodeProj)
    ]
}

// MARK: - Mocks

private final class TemporalPathBuidingMock: TemporalPathBuilding {
    struct BuildArguments {
        let path: URL
    }
    var buildArguments: BuildArguments?
    
    func build(at path: URL) throws -> URL {
        buildArguments = BuildArguments(path: path)
        return URL(fileURLWithPath: "tmp")
    }
    
    func getRootTemporalPath() -> String {
        fatalError()
    }
}

private final class PackageManifestBuildingMock: PackageManifestBuilding {
    struct BuildArguments {
        let path: URL
        let packageName: String
        let template: String
    }
    var buildArguments: BuildArguments?
    
    func build(at path: URL, packageName: String, template: String) throws {
        buildArguments = BuildArguments(path: path, packageName: packageName, template: template)
    }
}

private final class TemplateFilesCopingMock: TemplateFilesCoping {
    struct CopyTemplateArguments {
        let from: URL
        let to: URL
        let override: Bool
    }
    var copyTemplateArguments: CopyTemplateArguments?
    var templateName: String?
    
    func copyTemplate(from: URL, to: URL, override: Bool) throws {
        copyTemplateArguments = CopyTemplateArguments(from: from, to: to, override: override)
    }
    
    func restoreTemplate(from: URL, to: URL) throws {
        fatalError()
    }
    
    func getTemplateNameFrom(url: URL) throws -> String {
        templateName ?? ""
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
        podfileStub
    }
    
    func copyFile(from: URL, to: URL, override: Bool) throws {}
    
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

private final class BashMock: BashRunning {
    var bashArgument: String?
    
    func run(bash: String) {
        bashArgument = bash
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
