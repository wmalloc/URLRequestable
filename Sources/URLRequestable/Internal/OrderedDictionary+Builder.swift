//
//  OrderedDictionary+Builder.swift
//
//  Created by Waqar Malik on 5/31/23.
//

import Foundation
import OrderedCollections
import HTTPTypes

public extension HTTPHeaders {
    func add(_ header: HTTPField) -> Self {
        var headers = self
        headers[header.name] = header
        return headers
    }
}
