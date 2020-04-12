//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation

public typealias QueryParameters = [String: String]
public typealias HeaderParameters = [String: String]
public typealias Path = String

public enum Method: String {
    case get, post, put, patch, delete, head, options, connect, trace
}

public class Endpoint<RequestPayload, ResponsePayload> {
        
    let method: Method
    let path: Path
    let parameters: QueryParameters?
    let body: RequestPayload?
    let headers: HeaderParameters?
    let encode: (RequestPayload) throws -> Data
    let decode: (Data) throws -> ResponsePayload
    
    init(method: Method = .get,
         path: Path,
         parameters: QueryParameters? = nil,
         body: RequestPayload? = nil,
         headers: HeaderParameters? = nil,
         encode: @escaping (RequestPayload) throws -> Data,
         decode: @escaping (Data) throws -> ResponsePayload) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.body = body
        self.headers = headers
        self.encode = encode
        self.decode = decode
        
    }
    
    func url(base: URL) -> URL? {
        
        var components = URLComponents(url: base, resolvingAgainstBaseURL: true)
        var queryItems: [URLQueryItem] = []
        
        parameters?.forEach { parameter in
            queryItems.append(URLQueryItem(name: parameter.key, value: parameter.value))
        }
        
        components?.path += path
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        
        return components?.url
    }
    
}

extension Endpoint where RequestPayload == Void, ResponsePayload == Void {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: QueryParameters? = nil,
                     headers: HeaderParameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            headers: headers,
            encode: { _ in Data() },
            decode: { _ in () }
        )
    }
}

extension Endpoint where RequestPayload: Swift.Encodable, ResponsePayload: Swift.Decodable {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: QueryParameters? = nil,
                     body: RequestPayload? = nil,
                     headers: HeaderParameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            body: body,
            headers: headers,
            encode: { try JSONEncoder().encode($0) },
            decode: { try JSONDecoder().decode(ResponsePayload.self, from: $0) }
        )
    }
}

extension Endpoint where RequestPayload == Void, ResponsePayload: Swift.Decodable {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: QueryParameters? = nil,
                     headers: HeaderParameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            headers: headers,
            encode: { _ in Data() },
            decode: { try JSONDecoder().decode(ResponsePayload.self, from: $0) }
        )
    }
}

extension Endpoint where RequestPayload: Swift.Encodable, ResponsePayload == Void {
    convenience init(method: Method = .get,
                     path: Path,
                     parameters: QueryParameters? = nil,
                     body: RequestPayload? = nil,
                     headers: HeaderParameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            body: body,
            headers: headers,
            encode: { try JSONEncoder().encode($0) },
            decode: { _ in () }
        )
    }
}

