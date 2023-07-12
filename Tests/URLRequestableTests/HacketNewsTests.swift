//
//  HacketNewsTests.swift
//  
//
//  Created by Waqar Malik on 7/12/23.
//

import XCTest
@testable import URLRequestable
import HTTPTypes

final class HacketNewsTests: XCTestCase {
    let api = HackerNewsClient()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @available(iOS 15, *)
    func testTopStories() async throws {
        let topStories = try await api.topStories()
        XCTAssertEqual(topStories.count, 500)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
