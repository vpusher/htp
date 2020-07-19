//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation

protocol ClientProtocol {
    func fetch<RequestPayload, ResponsePayload>(_ endpoint: Endpoint<RequestPayload, ResponsePayload>, completion: @escaping ClientResult<ResponsePayload>) -> URLRequest?
}

public typealias ClientResult<ResponsePayload> = (Result<(ResponsePayload, HTTPURLResponse), APIError>) -> Void

public final class Client: ClientProtocol {
    
    static let shared = Client()
    private let queue = DispatchQueue(label: "net-\(UUID())")
    
    let session: URLSession
    let baseHeaders: HeaderParameters
    let baseURL: URL
    
    // To be used for frequent external updates like access token renewal or so. Overrides baseHeaders for same keys.
    public var additionalHeaders: HeaderParameters = [:]
    public var debug: Bool = false
        
    public init(baseURL: URL = URL(string: "http://localhost")!,
         baseHeaders: HeaderParameters = [:],
         session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.baseHeaders = baseHeaders
        self.session = session
    }
        
    @discardableResult
    public func fetch<RequestPayload, ResponsePayload>(_ endpoint: Endpoint<RequestPayload, ResponsePayload>, completion: @escaping ClientResult<ResponsePayload>) -> URLRequest? {
        
        guard let url = endpoint.url(base: baseURL) else {
            completion(.failure(.invalidEndpoint))
            return nil
        }
        
        var body: Data? = nil
        
        if let RequestPayload = endpoint.body {
            do {
                body = try endpoint.encode(RequestPayload)
            } catch {
                completion(.failure(.encodeError))
            }
        }
        
        // Copy headers.
        var headers = self.baseHeaders // Priority 2: base headers.
        headers.merge(additionalHeaders) { (_, additionalValue) in additionalValue } // Priority 1: additional headers.
        headers.merge(endpoint.headers ?? [:]) { (_, endpointValue) in endpointValue } // Priority 0: endpoint headers.
        
        let task = session.dataTask(with: url, method: endpoint.method, headers: headers, body: body, debug: debug) { result  in
            switch result {
                
            // SUCCESS
            case .success(let (resp, data)):
                
                guard let response = resp as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse(resp)))
                    return
                }
                
                let statusCode = response.statusCode
                
                // Handle server error.
                guard statusCode < 500 else {
                    completion(.failure(.serverError(response)))
                    return
                }
                
                // Handle client error.
                guard statusCode < 400 else {
                    completion(.failure(.clientError(response)))
                    return
                }
                
                // Handle redirection.
                guard statusCode < 300 else {
                    completion(.failure(.redirection(response)))
                    return
                }
                
                // Handle sucess.
                guard 200...299 ~= statusCode else {
                    completion(.failure(.noData(response)))
                    return
                }
                
                // Then decode if needed.
                do {
                    let value = try endpoint.decode(data)
                    completion(.success((value, response)))
                } catch (let error) {
                    if self.debug {
                        print(error)
                    }
                    completion(.failure(.decodeError(response)))
                }
                
            // FAILURE
            case .failure(let error):
                switch error {
                case .noResponse:
                    completion(.failure(.noResponse))
                case .wrappedError(let error, _):
                    completion(.failure(.unsupported(error)))
                }
            }
        }
        
        task.resume()
        
        return task.originalRequest

    }
    
}
