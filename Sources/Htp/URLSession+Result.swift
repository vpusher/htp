//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation

extension URLSession {
    
    func dataTask(with url: URL, method: Method = .get, headers: HeaderParameters? = nil, body: Data? = nil, debug: Bool = false, result: @escaping (Result<(URLResponse, Data), DataTaskError>) -> Void) -> URLSessionDataTask {
        
        // URL.
        var request = URLRequest(url: url)
        
        // Method.
        request.httpMethod = method.rawValue
        
        // Headers.
        headers?.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Request Payload/Body
        request.httpBody = body
        
        if debug {
            print("REQUEST - [\(request.hashValue)]\n\(request.cURL)")
        }
        
        return dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                if debug {
                    print("RESPONSE - [\(request.hashValue)]\n\(error)")
                }
                DispatchQueue.main.async {
                    result(.failure(.wrappedError(error, response)))
                }
                return
            }
            
            guard let response = response, let data = data else {
                DispatchQueue.main.async {
                    result(.failure(.noResponse))
                }
                return
            }
            
            if debug {
                if let playload = String(data: data, encoding: .utf8) {
                    print("\(response)\n\(playload)")
                } else {
                    print(response)
                }
            }
            
            DispatchQueue.main.async {
                result(.success((response, data)))
            }
        }
    }
}

public enum DataTaskError: Error {
    
    case noResponse
    case wrappedError(Error, URLResponse?)
    
}

