//
//  URLRequestable.swift
//
//  Created by Waqar Malik on 4/27/23.
//

import Foundation
import HTTPTypes

public typealias URLDataResponse = (data: Data, response: URLResponse)
public typealias Transformer<InputType, OutputType> = (InputType) throws -> OutputType

public protocol URLRequestable: HTTPRequstable {
	associatedtype ResultType

	typealias URLResponseTransformer = Transformer<URLDataResponse, ResultType>

	var apiBaseURLString: String { get }
  var queryItems: [URLQueryItem]? { get }
	var body: Data? { get }

	var transformer: URLResponseTransformer { get }
  
  func url(queryItems: [URLQueryItem]?) throws -> URL
	func urlRequest(headers: HTTPFields?, queryItems: [URLQueryItem]?) throws -> URLRequest
}

public extension URLRequestable {
  var queryItems: [URLQueryItem]? {
    nil
  }
  
	var body: Data? {
		nil
	}
  
  var apiBaseURLString: String {
    scheme + "://" + authority + path
  }
  
	func url(queryItems: [URLQueryItem]? = nil) throws -> URL {
		guard var components = URLComponents(string: apiBaseURLString) else {
			throw URLError(.badURL)
		}
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
			.addHeaderFields(self.headers)
			.addHeaderFields(headers)
			.setHttpBody(body, contentType: .json)
		return request
	}
}

public extension URLRequestable where ResultType: Decodable {
	var transformer: URLResponseTransformer {
		JSONDecoder.transformer()
	}
}
