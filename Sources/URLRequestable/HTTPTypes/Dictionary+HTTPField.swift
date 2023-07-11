//
//  Dictionary+HTTPField.swift
//
//  Created by Waqar Malik on 7/10/23.
//

import Foundation
import HTTPTypes

extension Dictionary where Key == AnyHashable, Value == Any {
    subscript(field: HTTPField) -> Any? {
        get {
            self[field.name.canonicalName] ?? self[field.name.rawName]
        }
        set {
            guard let value = newValue else {
                if removeValue(forKey: field.name.canonicalName) == nil {
                    removeValue(forKey: field.name.rawName)
                }
                return
            }
            self[field.name.canonicalName] = value
        }
    }
}
