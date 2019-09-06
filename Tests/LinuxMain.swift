import XCTest

import sysinfoTests

var tests = [XCTestCaseEntry]()
tests += sysinfoTests.allTests()
XCTMain(tests)
