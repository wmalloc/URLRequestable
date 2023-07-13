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
