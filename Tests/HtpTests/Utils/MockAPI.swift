//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation
import Swifter
@testable import Htp

struct MockAPI {}

extension MockAPI {
    
    static let testHeaderKey = "X-Test"
    static let testHeaderValue = "endpoint"
    
    static func getVoidVoid() -> Endpoint<Void, Void> {
        return Endpoint(
            method: .get,
            path: "/"
        )
    }
    
    static func getVoidVoidWithHeader() -> Endpoint<Void, Void> {
        return Endpoint(
            method: .get,
            path: "/",
            headers: [testHeaderKey: testHeaderValue]
        )
    }
    
    static func postPingVoid() -> Endpoint<Ping, Void> {
        return Endpoint(
            method: .post,
            path: "/ping",
            body: Ping()
        )
    }
    
    static func getVoidPong() -> Endpoint<Void, Pong> {
        return Endpoint(
            method: .get,
            path: "/ping"
        )
    }
    
    static func postPingPong() -> Endpoint<Ping, Pong> {
        return Endpoint(
            method: .post,
            path: "/ping",
            body: Ping()
        )
    }
    
    static func getError() -> Endpoint<Void, Void> {
        return Endpoint(
            method: .get,
            path: "/error"
        )
    }
    
    static func getRedirection() -> Endpoint<Void, Void> {
        return Endpoint(
            method: .get,
            path: "/redirection"
        )
    }
    
    // Not implemented server side on purpore (= client error).
    static func getUnknown() -> Endpoint<Void, Void> {
        return Endpoint(
            method: .get,
            path: "/unknown"
        )
    }
}

extension MockAPI {
    static public func buildServer() -> HttpServer {
        let server = HttpServer()
        server.GET["/"] = { request in .ok(.json([:]))  }
        server.GET["/ping"] = { request in .ok(.json(["message": "pong"])) }
        server.POST["/ping"] = { request in .ok(.json(["message": "pong"])) }
        server.GET["/error"] = { request in .internalServerError }
        server.GET["/redirection"] = { request in .movedTemporarily("/ping") }
        return server
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
