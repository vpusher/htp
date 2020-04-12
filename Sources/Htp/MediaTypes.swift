//
//  Created by Florian Maffini on 12.04.20.
//

import Foundation

public struct MediaTypes {
    
    /** The value of a type or subtype wildcard: "*" */
    static let mediaTypeWildcard = "*"
    
    /** "*&#47*" */
    static let wildcard = "*/*"
    
    /** "application/xml" */
    static let applicationXml = "application/xml"
    
    /** "application/atom+xml" */
    static let applicationAtomXml = "application/atom+xml"
    
    /** "application/xhtml+xml" */
    static let applicationXhtmlXml = "application/xhtml+xml"
    
    /** "application/svg+xml" */
    static let applicationSvgXml = "application/svg+xml"
    
    /** "application/json" */
    static let applicationJson = "application/json"
    
    /** "application/x-www-form-urlencoded" */
    static let applicationFormUrlencoded = "application/x-www-form-urlencoded"
    
    /** "multipart/form-data" */
    static let multipartFormData = "multipart/form-data"
    
    /** "application/octet-stream" */
    static let applicationOctetStream = "application/octet-stream"
    
    /** "text/plain" */
    static let textPlain = "text/plain"
    
    /** "text/xml" */
    static let textXml = "text/xml"
    
    /** "text/html" */
    static let textHtml = "text/html"
}
