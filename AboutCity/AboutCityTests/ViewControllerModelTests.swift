//
//  ViewControllerModelTests.swift
//  AboutCityTests
//
//  Created by Pratima Gauns on 7/1/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import XCTest
@testable import AboutCity

class ViewControllerModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFetchDataError() {
        let promise = expectation(description: "Error")
        
        DataAccessManager.sharedInstance.fetchData(searchURL: "") { (responseData, error) in
            if let _ = error, error!.rawValue == DataError.MissingSearchURL.rawValue {
                promise.fulfill()
            }
            else {
                XCTFail("Empty url returning invalid data")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchDataSuccess() {
        let promise = expectation(description: "Success")
        
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        DataAccessManager.sharedInstance.fetchData(searchURL: url) { (responseData, error) in
            if let _ = error {
                XCTFail("Valid URL returned error")
            }
            else {
                XCTAssert(responseData?.title! == "About Canada", "Incorrect Data Received")
                promise.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
