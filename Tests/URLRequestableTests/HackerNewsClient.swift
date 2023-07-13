//
//  HackerNewsClient.swift
//
//
//  Created by Waqar Malik on 7/12/23.
//

import Foundation
import URLRequestable

// https://github.com/HackerNews/API
class HackerNewsClient: URLRequestAsyncTransferable {
    let session: URLSession
    
    required init(session: URLSession = .shared) {
        self.session = session
    }
}

struct TopStoriesRequest: URLRequestable {
    let scheme: String = "https"
    let host: String = "hacker-news.firebaseio.com"
    
    typealias Response = [Int]
    var apiBaseURLString: String { "\(scheme)://\(host)" }
    let path: String = "/v0/topstories.json"
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "print", value: "pretty")]
    }
}
extension HackerNewsClient {
    @available(iOS 15, *)
    public func topStories() async throws -> TopStoriesRequest.Response {
        let request = TopStoriesRequest()
        return try await self.data(for: request, transformer: request.transformer)
    }
}
