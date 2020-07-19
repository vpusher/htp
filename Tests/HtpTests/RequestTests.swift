import XCTest
import Swifter
@testable import Htp

final class RequestTests: XCTestCase {
    
    private var client: Client!
    private var server: HttpServer!
    
    static let port: UInt16 = 9999
    
    override func setUp() {
        super.setUp()
        
        server = MockAPI.buildServer()
        
        //let semaphore = DispatchSemaphore(value: 0)
        do {
            try server.start(RequestTests.port)
          print("Server has started ( port = \(try server.port()) ).")
          //semaphore.wait()
        } catch {
          print("Server start error: \(error)")
          //semaphore.signal()
        }
        
        let url = URL(string: "http://localhost:\(RequestTests.port)")!
        self.client = Client(baseURL: url)
    }
    
    override func tearDown() {
        if server.operating {
            server.stop()
        }
        server = nil
        super.tearDown()
    }
    
    func testRequestGetVoidVoid() {

        let expectation = self.expectation(description: "request")
        
        client.fetch(MockAPI.getVoidVoid()) { (result) in
            switch result {
            case .success:
                expectation.fulfill()
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestGetVoidPong() {

        let expectation = self.expectation(description: "request")
        
        client.fetch(MockAPI.getVoidPong()) { (result) in
            switch result {
            case .success((let pong, _)):
                print(pong.message)
                expectation.fulfill()
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestPostPingVoid() {

        let expectation = self.expectation(description: "request")
        
        client.fetch(MockAPI.postPingVoid()) { (result) in
            switch result {
            case .success:
                expectation.fulfill()
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestPostPingPong() {

        let expectation = self.expectation(description: "request")
       
        client.fetch(MockAPI.postPingPong()) { (result) in
            switch result {
            case .success((let pong, _)):
                print(pong.message)
                expectation.fulfill()
                break
            case .failure(let error):
                print(error)
            }
           
        }
       
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestClientError() {

        let expectation = self.expectation(description: "request")
       
        client.fetch(MockAPI.getUnknown()) { (result) in
            switch result {
            case .success:
               break
            case .failure(let error):
                guard case .clientError = error else {
                    XCTFail()
                    return
                }
                expectation.fulfill()
            }
           
        }
       
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestServerError() {

        let expectation = self.expectation(description: "request")
       
        client.fetch(MockAPI.getError()) { (result) in
            switch result {
            case .success:
               break
            case .failure(let error):
                guard case .serverError = error else {
                    XCTFail()
                    return
                }
                expectation.fulfill()
            }
           
        }
       
        waitForExpectations(timeout: 3, handler: nil)
    }
    
//    func testRequestRedirection() {
//
//        let expectation = self.expectation(description: "request")
//
//        client.fetch(MockAPI.getRedirection()) { (result) in
//            switch result {
//            case .success:
//               break
//            case .failure(let error):
//                guard case .redirection = error else {
//                    XCTFail()
//                    return
//                }
//                expectation.fulfill()
//            }
//
//        }
//
//        waitForExpectations(timeout: 3, handler: nil)
//    }

    static var allTests = [
        ("testRequestGetVoidVoid", testRequestGetVoidVoid),
        ("testRequestGetVoidPong", testRequestGetVoidPong),
        ("testRequestPostPingVoid", testRequestPostPingVoid),
        ("testRequestPostPingPong", testRequestPostPingPong),
        ("testRequestClientError", testRequestClientError),
        ("testRequestServerError", testRequestServerError),
        //("testRequestRedirection", testRequestRedirection)
    ]
}
