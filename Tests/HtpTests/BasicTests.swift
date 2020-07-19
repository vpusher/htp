import XCTest
@testable import Htp

final class BasicTests: XCTestCase {
    
    func testCanInit() {
        XCTAssertNotNil(Client())
        XCTAssertNotNil(Client.shared)
    }
    
    func testHasDefaultProperties() {
        let client = Client()
        
        XCTAssertTrue(client.baseHeaders.isEmpty)
        XCTAssertEqual(client.baseURL.absoluteString, "http://localhost")
    }
    
    func testCreateCustomHeadersClient() {
        let client = Client(baseHeaders: [HttpHeaders.contentType: MediaTypes.applicationJson])
        
        XCTAssertEqual(client.baseHeaders.count, 1)
        XCTAssertEqual(client.baseHeaders[HttpHeaders.contentType], MediaTypes.applicationJson)
    }
    
    func testCreateCustomUrlClient() {
        let url = URL(string: "http://test")!
        let client = Client(baseURL: url)
        
        XCTAssertEqual(client.baseURL, url)
    }
    
    func testEndpointHeadersPriority0() {
        
        let client = Client(baseHeaders: [MockAPI.testHeaderKey: "base"])
        client.additionalHeaders[MockAPI.testHeaderKey] = "add"
        
        let request = client.fetch(MockAPI.getVoidVoidWithHeader()) { _ in }
        
        XCTAssertEqual(request?.allHTTPHeaderFields?[MockAPI.testHeaderKey], MockAPI.testHeaderValue)
    }
    
    func testAdditionalHeadersPriority1() {
        
        let client = Client(baseHeaders: [MockAPI.testHeaderKey: "base"])
        client.additionalHeaders[MockAPI.testHeaderKey] = "add"
        
        let request = client.fetch(MockAPI.getVoidVoid()) { _ in }
        
        XCTAssertEqual(request?.allHTTPHeaderFields?[MockAPI.testHeaderKey], "add")
    }
    
    func testBaseHeadersPriority2() {
        
        let client = Client(baseHeaders: [MockAPI.testHeaderKey: "base"])
                
        let request = client.fetch(MockAPI.getVoidVoid()) { _ in }
        
        XCTAssertEqual(request?.allHTTPHeaderFields?[MockAPI.testHeaderKey], "base")
    }

    static var allTests = [
        ("testCanInit", testCanInit),
        ("testHasDefaultProperties", testHasDefaultProperties),
        ("testCreateCustomHeadersClient", testCreateCustomHeadersClient),
        ("testCreateCustomUrlClient", testCreateCustomUrlClient),
        ("testEndpointHeadersPriority0", testEndpointHeadersPriority0),
        ("testAdditionalHeadersPriority1", testAdditionalHeadersPriority1),
        ("testBaseHeadersPriority2", testBaseHeadersPriority2),
    ]
}
