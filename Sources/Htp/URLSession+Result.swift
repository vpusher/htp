//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation

extension URLSession {
    
    func dataTask(with url: URL, method: Method = .get, headers: HeaderParameters? = nil, body: Data? = nil, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        
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
        
        print("REQUEST - [\(request.hashValue)]\n\(request.cURL)")
        
        return dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("RESPONSE - [\(request.hashValue)]\n\(error)")
                result(.failure(error))
                return
            }
            
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            
            if let playload = String(data: data, encoding: .utf8) {
                print("\(response)\n\(playload)")
            } else {
                print(response)
            }
            
            result(.success((response, data)))
        }
    }
}

