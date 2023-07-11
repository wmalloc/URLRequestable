//
//  HTTPRequestable.swift
//
//  Created by Waqar Malik on 7/10/23.
//

import Foundation
import HTTPTypes

public typealias HTTPDataResponse = (data: Data, response: HTTPResponse)

public protocol HTTPRequestable {
    associatedtype Response

    typealias ResponseTransformer = Transformer<HTTPDataResponse, Response>

    var scheme: String { get }
    var host: String { get }
    var method: HTTPRequest.Method { get }
    var path: String { get }
    var headers: HTTPFields { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }

    var transformer: ResponseTransformer { get }

    func url(queryItems: [URLQueryItem]?) throws -> URL
    func urlRequest(headers: HTTPFields?, queryItems: [URLQueryItem]?) throws -> HTTPRequest
}


