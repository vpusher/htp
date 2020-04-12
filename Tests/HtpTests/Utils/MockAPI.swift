//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation
@testable import Htp

struct MockAPI {}

extension MockAPI {
    
    static let testHeaderKey = "X-Test"
    static let testHeaderValue = "endpoint"
    
    static func get() -> Endpoint<Void, Void> {
        return Endpoint(
            method: .get,
            path: "/"
        )
    }
    
    static func customGet() -> Endpoint<Void, Void> {
        return Endpoint(
            method: .get,
            path: "/",
            headers: [testHeaderKey: testHeaderValue]
        )
    }
    
    static func postPing() -> Endpoint<Ping, Void> {
        return Endpoint(
            method: .post,
            path: "/",
            body: Ping()
        )
    }
    
    static func getPong() -> Endpoint<Void, Pong> {
        return Endpoint(
            method: .get,
            path: "/"
        )
    }
    
    static func postPingPong() -> Endpoint<Ping, Pong> {
        return Endpoint(
            method: .post,
            path: "/",
            body: Ping()
        )
    }
}

// MARK: - REQUEST PAYLOADS

struct Ping: Encodable {
    let message: String
    
    init() {
        message = "ping"
    }
}

// MARK: - RESPONSE PAYLOADS

struct Pong: Decodable {
    let message: String
    
    init() {
        message = "pong"
    }
}
