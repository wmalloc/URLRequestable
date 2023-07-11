//
//  HTTPURLResponse+Validation.swift
//
//  Created by Waqar Malik on 4/27/23.
//

import Foundation

public extension HTTPURLResponse {
    @discardableResult
    func url_httpValidate(acceptableStatusCodes: Range<Int> = 200 ..< 300, acceptableContentTypes: Set<String>? = nil) throws -> Self {
        try url_httpValidateStatusCode(acceptableStatusCodes: acceptableStatusCodes)
            .url_httpValidateContentType(acceptableContentTypes: acceptableContentTypes)
    }

    @discardableResult
    func url_httpValidateStatusCode(acceptableStatusCodes: Range<Int> = 200 ..< 300) throws -> Self {
        guard acceptableStatusCodes.contains(statusCode) else {
            let errorCode = URLError.Code(rawValue: statusCode)
            throw URLError(errorCode)
        }
        return self
    }
    
    @discardableResult
    func url_httpValidateContentType(acceptableContentTypes: Set<String>? = nil) throws -> Self {
        if let validContentType = acceptableContentTypes {
            if let contentType = (allHeaderFields[HTTPHeaderType.contentType] ?? allHeaderFields[HTTPHeaderType.contentType.lowercased()])  as? String {
                if !validContentType.contains(contentType) {
                    throw URLError(.dataNotAllowed)
                }
            } else {
                throw URLError(.badServerResponse)
            }
        }
        return self
    }
}
