//
//  File.swift
//
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import HTTPTypes

public extension URLSessionConfiguration {
    var httpAdditionalFields: HTTPFields? {
        get {
            guard let httpAdditionalHeaders else {
                return nil
            }
            
            let headers = httpAdditionalHeaders.compactMap { (key: AnyHashable, value: Any) -> HTTPField? in
                guard let name = key as? String, let fieldName = HTTPField.Name(name), let valueString = value as? String else {
                    return nil
                }
                return HTTPField(name: fieldName, value: valueString)
            }
            guard !headers.isEmpty else {
                return nil
            }
            
            return HTTPFields(headers)
        }
        set {
            guard let fields = newValue else {
                return
            }
            
            let headers = fields.reduce([:]) { partialResult, field in
                var result = partialResult
                result[field.name.canonicalName] = field.value
                return result
            }
            httpAdditionalHeaders = headers
        }
    }
}
