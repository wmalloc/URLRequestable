//
//  HTTPFields+Defaults.swift
//
//
//  Created by Waqar Malik on 1/15/23.
//

import Foundation
import HTTPTypes

public extension HTTPFields {
  static var defaultHeaders: HTTPFields {
    HTTPFields([HTTPField.defaultUserAgent])
  }
}
