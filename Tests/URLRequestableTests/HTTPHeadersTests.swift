//
//  HTTPHeadersTests.swift
//
//
//  Created by Waqar Malik on 1/15/23.
//  Copyright © 2020 Waqar Malik All rights reserved.
//

@testable import URLRequestable
import XCTest
import HTTPTypes

final class HTTPHeadersTests: XCTestCase {
	func testBaseHeaders() throws {
		let headers = HTTPFields([.defaultAcceptLanguage, .defaultAcceptEncoding, .defaultUserAgent])
        
		XCTAssertFalse(headers.isEmpty)
		XCTAssertEqual(headers.count, 3)
		XCTAssertTrue(headers.contains(.defaultUserAgent))
		XCTAssertFalse(headers.contains(.contentType(.json)))
	}

	func testURLSessionConfiguration() throws {
		let session = URLSessionConfiguration.default
		session.httpAdditionalFields = HTTPFields.defaultHeaders
		XCTAssertEqual(session.httpAdditionalFields?.count, 3)

		let headers = session.httpAdditionalHeaders
		XCTAssertEqual(headers?.count, 3)
	}

	func testURLRequestHeaders() throws {
		let request = URLRequest(url: URL(string: "https://api.github.com")!)
			.setMethod(.get)
			.setUserAgent(String.url_userAgent)
			.setFields(HTTPFields.defaultHeaders)
			.addHeader(HTTPField.accept(.json))

		let headers = request.headers
		XCTAssertNotNil(headers)
		XCTAssertEqual(headers?.count, 4)
		XCTAssertFalse(headers!.contains(.contentType(.xml)))
		XCTAssertTrue(headers!.contains(.defaultAcceptLanguage))
	}

	func testDictionary() throws {
		var headers = HTTPFields()
        headers.append(.contentType(.xml))
        XCTAssertEqual(headers.count, 1)
        XCTAssertEqual(headers[.contentType], .xml)
        headers.append(.contentType(.json))
		XCTAssertEqual(headers.count, 1)
		XCTAssertEqual(headers[.contentType], .json)
		headers.append(HTTPField(name: .authorization, value: "Password"))
        headers.append(HTTPField(name: .contentLength, value: "\(0)"))
        headers.append(.authorization(token: "Token"))
		XCTAssertEqual(headers.count, 3)
		let dictionary = headers.dictionary
		XCTAssertEqual(dictionary.count, 3)
	}
}
