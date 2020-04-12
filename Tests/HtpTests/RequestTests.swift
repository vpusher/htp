import XCTest
@testable import Htp

final class RequestTests: XCTestCase {
    
    func testRequestVoidVoid() {

        let expectation = self.expectation(description: "request")
        
        Client.shared.fetch(MockAPI.getPong()) { (result) in
            switch result {
            case .success((let pong, _)):
                print(pong.message)
                break
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    static var allTests = [
        ("testRequestVoidVoid", testRequestVoidVoid),
    ]
}
