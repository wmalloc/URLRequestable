//
//  HTTPFields+Defaults.swift
//
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import HTTPTypes

public extension HTTPFields {
    static var defaultHeaders: HTTPFields {
        HTTPFields([.defaultUserAgent, .defaultAcceptEncoding, .defaultAcceptLanguage])
    }
}

public extension HTTPFields {
    var dictionary: [String: String] {
        var items: [String: String] = [:]
        for item in self {
            items[item.name.canonicalName] = item.value
        }
        
        return items
    }
}
