//
//  HTTPField+QualityEncoded.swift
//
//  Created by Waqar Malik on 7/10/23.
//

import Foundation
import HTTPTypes

public extension HTTPField {
    init(name: Name, qualityEncoded: some Collection<String>) {
        self.init(name: name, value: qualityEncoded.url_qualityEncoded)
    }
}
