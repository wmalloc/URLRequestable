//
//  URLRequestable.swift
//
//  Created by Waqar Malik on 4/27/23.
//

import Foundation
import HTTPTypes
import HTTPTypesFoundation

public typealias URLDataResponse = DataResponse<URLResponse>

public protocol URLRequestable: HTTPRequestable {
    typealias ResponseTransformer = Transformer<DataResponse<URLResponse>, Response>

    var apiBaseURLString: String { get }
    var body: Data? { get }
    var transformer: ResponseTransformer { get }
    
    func url(queryItems: [URLQueryItem]?) throws -> URL
    func urlRequest(headers: HTTPFields?, queryItems: [URLQueryItem]?) throws -> URLRequest
}

public extension URLRequestable {    
    var body: Data? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        nil
    }
    
    func url(queryItems: [URLQueryItem]? = nil) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        var items = self.queryItems ?? []
        items.append(contentsOf: queryItems ?? [])
        components = components
            .appendQueryItems(items)
            .setPath(path)
        guard let url = components.url else {
            throw URLError(.unsupportedURL)
        }
        return url
    }
    
    func urlRequest(headers: HTTPFields? = nil, queryItems: [URLQueryItem]? = nil) throws -> URLRequest {
        let url = try url(queryItems: queryItems)
        let request = URLRequest(url: url)
            .setMethod(method)
            .addFields(headerFields)
            .addFields(headers)
            .setHttpBody(body, contentType: .json)
        return request
    }
}

public extension URLRequestable where Response: Decodable {
    var transformer: ResponseTransformer {
        JSONDecoder.transformer()
    }
}
