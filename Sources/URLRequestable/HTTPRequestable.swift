//
//  HTTPRequestable.swift
//
//  Created by Waqar Malik on 7/10/23.
//

import Foundation
import HTTPTypes
import HTTPTypesFoundation

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
    func httpRequest(headers: HTTPFields?, queryItems: [URLQueryItem]?) throws -> HTTPRequest
}

public extension HTTPRequestable {
    var method: HTTPRequest.Method {
        .get
    }

    var headers: HTTPFields {
        HTTPFields()
    }

    var body: Data? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    func url(queryItems: [URLQueryItem]? = nil) throws -> URL {
        var components = URLComponents(string: host)
        components?.scheme = scheme
        var items = self.queryItems ?? []
        items.append(contentsOf: queryItems ?? [])
        components = components?
            .appendQueryItems(items)
            .setPath(path)
        guard let url = components?.url else {
            throw URLError(.unsupportedURL)
        }
        return url
    }

    func httpRequest(headers: HTTPFields?, queryItems: [URLQueryItem]?) throws -> HTTPRequest {
        let url = try url(queryItems: queryItems)
        var fields = self.headers
        if let headers {
            fields.append(contentsOf: headers)
        }
        let request = HTTPRequest(method: method, url: url, headerFields: fields)
        return request
    }
}
