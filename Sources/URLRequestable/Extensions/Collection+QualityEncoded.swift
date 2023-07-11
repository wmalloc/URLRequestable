//
//  Collection+QualityEncoded.swift
//
//  Created by Waqar Malik on 4/28/23.
//

import Foundation

extension Collection<String> {
    var url_qualityEncoded: Element {
        enumerated().map { index, value in
            let quality = 1.0 - (Double(index) * 0.1)
            return "\(value);q=\(quality)"
        }.joined(separator: ", ")
    }
}
