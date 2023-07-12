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
