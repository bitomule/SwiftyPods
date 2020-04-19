import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PackageBuilderTests.allTests),
        testCase(PackageManifestBuilderTests.allTests),
        testCase(TemplateFilesManagerTests.allTests)
    ]
}
#endif
