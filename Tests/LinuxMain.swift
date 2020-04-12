import XCTest

import HtpTests

var tests = [XCTestCaseEntry]()
tests += BasicTests.allTests()
tests += RequestTests.allTests()
XCTMain(tests)
