//
//  Dictionary+HTTPField.swift
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import HTTPTypes

public extension Dictionary where Key == AnyHashable, Value == Any {
    subscript(name: HTTPField.Name) -> Value? {
        get {
            self[name.canonicalName] ?? self[name.rawName]
        }
        set {
            guard let value = newValue else {
                if self.removeValue(forKey: name.canonicalName) == nil {
                    self.removeValue(forKey: name.rawName)
                }
                return
            }
            
            self[name.canonicalName] = value
        }
    }
}
