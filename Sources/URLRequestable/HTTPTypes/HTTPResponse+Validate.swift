//
//  HTTPResponse+Validate.swift
//
//  Created by Waqar Malik on 7/10/23.
//

import Foundation
import HTTPTypes

extension HTTPResponse {
    @discardableResult
    func url_validate(acceptableContentTypes: Set<String>? = nil) throws -> Self {
        guard status.kind == .successful else {
            let errorCode = URLError.Code(rawValue: status.code)
            throw URLError(errorCode)
        }

        if let validContentType = acceptableContentTypes {
            if let contentType = headerFields[.contentType] {
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
