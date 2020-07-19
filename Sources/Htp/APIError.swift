//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation

public enum APIError: Error {
    
    case clientError(HTTPURLResponse?)
    
    case serverError(HTTPURLResponse?)
    
    case redirection(HTTPURLResponse?)
    
    case invalidEndpoint
    
    case invalidResponse(URLResponse?)
    
    case unsupported(Error)
    
    case noResponse
    
    case noData(HTTPURLResponse?)
    
    case decodeError(HTTPURLResponse?)
    
    case encodeError
    
}
