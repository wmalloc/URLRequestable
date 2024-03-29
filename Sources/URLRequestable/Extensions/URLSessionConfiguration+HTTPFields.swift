//
//  URLSessionConfiguration+HTTPFields.swift
//
//  Created by Waqar Malik on 1/14/23.
//  Copyright © 2020 Waqar Malik All rights reserved.
//

import Foundation
import HTTPTypes

public extension URLSessionConfiguration {
	var headers: HTTPFields? {
		get {
			let result = httpAdditionalHeaders?.compactMap { (key: AnyHashable, value: Any) -> HTTPField? in
				guard let key = key as? String, let value = value as? String, let name = HTTPField.Name(key) else {
					return nil
				}
				return HTTPField(name: name, value: value)
			}
			guard let result, !result.isEmpty else {
				return nil
			}
			return HTTPFields(result)
		}
		set {
			httpAdditionalHeaders = newValue?.rawValue
		}
	}
}
