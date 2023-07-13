//
//  HTTPRequestable.swift
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import HTTPTypes
import HTTPTypesFoundation

public typealias HTTPDataResponse = DataResponse<HTTPResponse>

public protocol HTTPRequestable {
    associatedtype Response

    var method: URLRequest.Method { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var headerFields: HTTPFields? { get }
    var queryItems: [URLQueryItem]? { get }
    
    func httpRequest(headers: HTTPFields?, queryItems: [URLQueryItem]?) throws -> HTTPRequest
}

public extension HTTPRequestable {
    var scheme: String {
        "https"
    }

    var method: URLRequest.Method {
        .get
    }

    var headerFields: HTTPFields? {
        var fields = HTTPFields.defaultHeaders
        fields.append(.accept(.json))
        return fields
    }
    
    func httpRequest(headers: HTTPFields?, queryItems: [URLQueryItem]?) throws -> HTTPRequest {
        var request = HTTPRequest(method: method, scheme: scheme, authority: host, path: path)
        if let headerFields {
            for field in headerFields {
                request.headerFields.append(field)
            }
        }
        
        if let headers {
            for field in headers {
                request.headerFields.append(field)
            }
        }
        return request
    }
}

