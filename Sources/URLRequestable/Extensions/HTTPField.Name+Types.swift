//
//  HTTPField.Name+Types.swift
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import HTTPTypes

public extension HTTPField.Name {
    static var userAuthorization: Self { .init("User-Authorization")! }
    static var xAPIKey: Self { .init("X-API-Key")! }
}
