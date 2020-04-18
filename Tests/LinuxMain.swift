import XCTest

import SwiftyPodsTests
import TemplateRendererTests

var tests = [XCTestCaseEntry]()
tests += SwiftyPodsTests.allTests()
tests += TemplateRendererTests.allTests()
XCTMain(tests)
