//
//  HandsOnUnitTestingSlowTest.swift
//  HandsOnUnitTestingSlowTest
//
//  Created by Fardan Akhter on 8/28/21.
//

import XCTest
import Network
@testable import HandsOnUnitTesting

// This Test Target is for Slow Asynchrounous opertions testing
class HandsOnUnitTestingSlowTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
        // given
        let urlString =
            "https://www.google.com/"
        let url = URL(string: urlString)!
        // 1
        let promise = expectation(description: "Status code: 200") // XCTestExpectation

        // when
        let dataTask = URLSession.shared.dataTask(with: url) { _, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill() // signal that XCTestExpectation is met
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 2) // This waits until all expectations are fulfilled or timeout is reached , which ever happens first
    }
    
    
    // This test API call if network connection is present
    func testApiCallCompletesIfNetworkConnectionIsFound() throws {
        
        // given
        let monitor = NWPathMonitor()
        var isNetworkReachable: Bool = true //= monitor.currentPath.status == .satisfied
        
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { path in
            isNetworkReachable = path.status == .satisfied
        }
        
        // skip with proceeding test if no Network Connection, results in neither success nor failure
        try XCTSkipIf(!isNetworkReachable, "Network Connection Failed!")
        
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        // when
        let dataTask = URLSession.shared.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)

        // then
        XCTAssertNil(responseError) // success if responseError = nil
        XCTAssertEqual(statusCode, 200) // success if statusCode = 200
    }
}
