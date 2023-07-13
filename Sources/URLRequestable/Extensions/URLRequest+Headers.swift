//
//  File.swift
//
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import HTTPTypes

public extension URLRequest {
    var headers: HTTPFields? {
        get {
            guard let allHTTPHeaderFields else {
                return nil
            }
            
            let fields: [HTTPField] = allHTTPHeaderFields.compactMap { (key: String, value: String) in
                guard let name = HTTPField.Name(key) else {
                    return nil
                }
                return HTTPField(name: name, value: value)
            }
            guard !fields.isEmpty else {
                return nil
            }
            
            return HTTPFields(fields)
        }
        set {
            guard let fields = newValue else {
                return
            }
            for field in fields {
                self.addValue(field.value, forHTTPHeaderField: field.name.canonicalName)
            }
        }
    }
}
