//
//  HTTPFieldName+Custom.swift
//
//  Created by Waqar Malik on 7/10/23.
//

import Foundation
import HTTPTypes

public extension HTTPField.Name {
    static var acceptCharset: Self { .init("Accept-Charset")! }
    static var userAuthorization: Self { .init("User-Authorization")! }
    static var xAPIKey: Self { .init("X-API-Key")! }
}
