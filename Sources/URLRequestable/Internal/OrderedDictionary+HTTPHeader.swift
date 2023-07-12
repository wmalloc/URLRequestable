//
//  OrderedDictionary+HTTPHeader.swift
//
//  Created by Waqar Malik on 5/31/23.
//

import Foundation
import OrderedCollections
import HTTPTypes

extension HTTPHeaders: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: HTTPField...) {
        self.init()
        elements.forEach { self[$0.name] = $0 }
    }
}

public extension HTTPHeaders {
    init(_ headers: [HTTPField]) {
        self.init()
        headers.forEach { self[$0.name] = $0}
    }
    
    var headers: [HTTPField] {
        elements.map { (key: HTTPField.Name, value: HTTPField) in
            value
        }
    }
    
    var dictionary: [String: String] {
        var dictionary: [String: String] = [:]
        for item in self {
            dictionary[item.key.canonicalName] = item.value.value
        }
        return dictionary
    }
    
    func contains(_ header: HTTPField) -> Bool {
        self[header.name] != nil
    }
}
