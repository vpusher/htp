import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BasicTests.allTests),
        testCase(RequestTests.allTests),
    ]
}
#endif
