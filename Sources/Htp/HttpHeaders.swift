//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation

public struct HttpHeaders {
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1 HTTP/1.1 documentation.
     */
    static let accept = "Accept"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.2 HTTP/1.1 documentation.
     */
    static let acceptCharset = "Accept-Charset"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3 HTTP/1.1 documentation.
     */
    static let acceptEncoding = "Accept-Encoding"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4 HTTP/1.1 documentation.
     */
    static let acceptLanguage = "Accept-Language"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.8 HTTP/1.1 documentation.
     */
    static let authorization = "Authorization"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9 HTTP/1.1 documentation.
     */
    static let cacheControl = "Cache-Control"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11 HTTP/1.1 documentation.
     */
    static let contentEncoding = "Content-Encoding"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.12 HTTP/1.1 documentation.
     */
    static let contentLanguage = "Content-Language"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.13 HTTP/1.1 documentation.
     */
    static let contentLength = "Content-Length"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.14 HTTP/1.1 documentation.
     */
    static let contentLocation = "Content-Location"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17 HTTP/1.1 documentation.
     */
    static let contentType = "Content-Type"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.18 HTTP/1.1 documentation.
     */
    static let date = "Date"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.19 HTTP/1.1 documentation.
     */
    static let etag = "ETag"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21 HTTP/1.1 documentation.
     */
    static let expires = "Expires"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.23 HTTP/1.1 documentation.
     */
    static let host = "Host"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.24 HTTP/1.1 documentation.
     */
    static let ifMatch = "If-Match"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.25 HTTP/1.1 documentation.
     */
    static let ifModifiedSince = "If-Modified-Since"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.26 HTTP/1.1 documentation.
     */
    static let ifNoneMatch = "If-None-Match"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.28 HTTP/1.1 documentation.
     */
    static let ifUnmodifiedSince = "If-Unmodified-Since"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.29 HTTP/1.1 documentation.
     */
    static let lastModified = "Last-Modified"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.30 HTTP/1.1 documentation.
     */
    static let location = "Location"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43 HTTP/1.1 documentation.
     */
    static let userAgent = "User-Agent"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.44 HTTP/1.1 documentation.
     */
    static let vary = "Vary"
    
    /**
     * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.47 HTTP/1.1 documentation.
     */
    static let wwwAuthenticate = "WWW-Authenticate"
    
    /**
     * See http://www.ietf.org/rfc/rfc2109.txt IETF RFC 2109.
     */
    static let cookie = "Cookie"
    
    /**
     * See http://www.ietf.org/rfc/rfc2109.txt IETF RFC 2109.
     */
    static let setCookie = "Set-Cookie"
}
