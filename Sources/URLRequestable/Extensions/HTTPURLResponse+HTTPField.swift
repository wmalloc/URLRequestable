//
//  HTTPURLResponse+HTTPFieldName.swift
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import HTTPTypes

public extension HTTPURLResponse {
    func value(forHTTPHeaderField field: HTTPField.Name) -> String? {
        self.value(forHTTPHeaderField: field.canonicalName) ?? value(forHTTPHeaderField: field.rawName)
    }
}

public extension HTTPURLResponse {
    var allHeaders: HTTPFields? {
        let fields: [HTTPField] = allHeaderFields.compactMap { (key, value) in
            guard let nameString = key as? String, let valueString = value as? String else {
                return nil
            }
            guard let name = HTTPField.Name(nameString) else {
                return nil
            }
            return HTTPField(name: name, value: valueString)
        }
        guard !fields.isEmpty else {
            return nil
        }
        
        return HTTPFields(fields)
    }
}
